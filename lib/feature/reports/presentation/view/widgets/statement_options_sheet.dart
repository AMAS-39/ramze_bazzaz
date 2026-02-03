import 'dart:io';

import 'package:app/core/shared/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import '../../../data/models/customer_statement_model.dart';
import '../../../domain/repositories/reports_repository.dart';

/// Types of statements that can be generated as PDFs.
enum PdfType { statement, payInstead }

/// Shows the bottom sheet that lets the user pick which statement to generate.
Future<void> showStatementOptionsSheet(BuildContext context) async {
  logger('STATEMENTS: opening options sheet');

  final selectedType = await showModalBottomSheet<PdfType>(
    context: context,
    builder: (sheetContext) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.picture_as_pdf_outlined),
              title: Text(Trans.customerAccountStatement.trans(context: context)),
              onTap: () => Navigator.of(sheetContext).pop(PdfType.statement),
            ),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf),
              title:
                  Text(Trans.customerPayInsteadStatement.trans(context: context)),
              onTap: () => Navigator.of(sheetContext).pop(PdfType.payInstead),
            ),
          ],
        ),
      );
    },
  );

  if (selectedType == null) {
    logger('STATEMENTS: user dismissed options sheet without selection');
    return;
  }

  logger('STATEMENTS: user selected type = $selectedType');
  await _handlePdfGeneration(context, selectedType);
}

/// Fetches the chosen statement from the backend, generates the PDF,
/// and then opens/shares it.
Future<void> _handlePdfGeneration(BuildContext context, PdfType type) async {
  logger('STATEMENTS: _handlePdfGeneration start, type = $type');
  final navigator = Navigator.of(context);

  // Simple loading dialog.
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Center(child: CircularProgressIndicator()),
  );

  try {
    final repo = sl<ReportsRepository>();
    logger('STATEMENTS: fetching statement from repository...');

    final result = type == PdfType.statement
        ? await repo.fetchCustomerAccountStatement()
        : await repo.fetchCustomerPayInsteadStatement();

    if (result.isLeft()) {
      navigator.pop(); // close loading
      final failure = result.getLeft();
      final msg = failure?.error.message ?? Trans.error.trans(context: context);
      logger('STATEMENTS: repository returned FAILURE -> $msg');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      return;
    }

    final statement =
        result.getRight(() => const CustomerAccountStatement(items: []))!;
    logger('STATEMENTS: repository returned SUCCESS with '
        '${statement.items.length} items');

    logger('STATEMENTS: generating ${type == PdfType.statement ? "account" : "pay instead"} PDF...');
    final pdfPath = type == PdfType.statement
        ? await PdfGenerator.generateStatementPdf(statement)
        : await PdfGenerator.generatePayInsteadPdf(statement);

    navigator.pop(); // close loading

    logger('STATEMENTS: PDF generated at path = $pdfPath');

    // Share and open the PDF.
    await Share.shareXFiles(
      [XFile(pdfPath)],
      text: type == PdfType.statement
          ? Trans.customerAccountStatement.trans(context: context)
          : Trans.customerPayInsteadStatement.trans(context: context),
    );

    logger('STATEMENTS: opening PDF with OpenFilex...');
    await OpenFilex.open(pdfPath);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          type == PdfType.statement
              ? Trans.customerAccountStatement.trans(context: context)
              : Trans.payInsteadStatementGeneratedSuccessfully
                  .trans(context: context),
        ),
      ),
    );
  } catch (e, st) {
    navigator.pop(); // close loading
    logger('STATEMENTS: unexpected error during PDF generation: $e\n$st');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(Trans.error.trans(context: context))),
    );
  }
}

class PdfGenerator {
  static final NumberFormat _currencyFormat = NumberFormat.currency(
    symbol: '\$',
    decimalDigits: 2,
  );
  static final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  static Future<String> generateStatementPdf(
    CustomerAccountStatement statement,
  ) async {
    final baseFont =
        await _tryLoadFont('assets/fonts/NotoSans-Regular.ttf') ??
        pw.Font.helvetica();
    final boldFont =
        await _tryLoadFont('assets/fonts/NotoSans-Bold.ttf') ??
        pw.Font.helveticaBold();
    final arabicFont = await _tryLoadFont(
      'assets/fonts/NotoSansArabic-Regular.ttf',
    );
    final arabicBoldFont = await _tryLoadFont(
      'assets/fonts/NotoSansArabic-Bold.ttf',
    );
    final logoImage = await _tryLoadImage(appConfig.logo);

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        theme: pw.ThemeData.withFont(
          base: baseFont,
          bold: boldFont,
          fontFallback: [
            if (arabicFont != null) arabicFont,
            if (arabicBoldFont != null) arabicBoldFont,
          ],
        ),
        build: (pw.Context context) {
          return [
            _buildHeader(
              context,
              'CUSTOMER ACCOUNT STATEMENT',
              statement,
              logoImage,
              baseFont,
              boldFont,
              arabicFont,
            ),
            pw.SizedBox(height: 20),
            _buildSummary(statement),
            pw.SizedBox(height: 20),
            _buildStatementTable(statement, baseFont, arabicFont),
            pw.SizedBox(height: 20),
            _buildFooter(statement),
          ];
        },
      ),
    );

    return _savePdf(pdf, 'statement');
  }

  static Future<String> generatePayInsteadPdf(
    CustomerAccountStatement statement,
  ) async {
    final baseFont =
        await _tryLoadFont('assets/fonts/NotoSans-Regular.ttf') ??
        pw.Font.helvetica();
    final boldFont =
        await _tryLoadFont('assets/fonts/NotoSans-Bold.ttf') ??
        pw.Font.helveticaBold();
    final arabicFont = await _tryLoadFont(
      'assets/fonts/NotoSansArabic-Regular.ttf',
    );
    final arabicBoldFont = await _tryLoadFont(
      'assets/fonts/NotoSansArabic-Bold.ttf',
    );
    final logoImage = await _tryLoadImage(appConfig.logo);

    final pdf = pw.Document();

    // Filter items for Pay Instead
    final payInsteadItems = statement.items
        .where(
          (item) =>
              (item.description?.toLowerCase().contains('payinstead') ??
                  false) ||
              (item.description?.toLowerCase().contains('pay instead') ??
                  false) ||
              (item.description?.toLowerCase().contains('customer payreturn') ??
                  false),
        )
        .toList();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        theme: pw.ThemeData.withFont(
          base: baseFont,
          bold: boldFont,
          fontFallback: [
            if (arabicFont != null) arabicFont,
            if (arabicBoldFont != null) arabicBoldFont,
          ],
        ),
        build: (pw.Context context) {
          return [
            _buildHeader(
              context,
              'CUSTOMER PAY INSTEAD STATEMENT',
              statement,
              logoImage,
              baseFont,
              boldFont,
              arabicFont,
            ),
            pw.SizedBox(height: 20),
            _buildPayInsteadSummary(statement),
            pw.SizedBox(height: 20),
            _buildPayInsteadTable(
              payInsteadItems,
              statement.initialPayInstead ?? 0,
              baseFont,
              arabicFont,
            ),
            pw.SizedBox(height: 20),
            _buildPayInsteadFooter(statement),
          ];
        },
      ),
    );

    return _savePdf(pdf, 'pay_instead');
  }

  static pw.Widget _buildHeader(
    pw.Context context,
    String title,
    CustomerAccountStatement statement,
    pw.ImageProvider? logoImage,
    pw.Font baseFont,
    pw.Font boldFont,
    pw.Font? arabicFont,
  ) {
    // Get customer name, preserve original format (especially for Arabic/Kurdish)
    final customerName = statement.customerName?.trim() ?? '';
    // Only show if it's not empty and doesn't look like a username
    final displayCustomerName = customerName.isNotEmpty ? customerName : 'N/A';

    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 12),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(color: PdfColors.grey400, width: 1),
        ),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Logo and Title Row
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              if (logoImage != null)
                pw.Container(
                  width: 80,
                  height: 80,
                  child: pw.Image(logoImage, fit: pw.BoxFit.contain),
                )
              else
                pw.SizedBox(width: 80),
              pw.Expanded(
                child: pw.Text(
                  title,
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                    letterSpacing: 0.5,
                    font: boldFont,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
              ),
              pw.SizedBox(width: 80), // Balance the logo width
            ],
          ),
          pw.SizedBox(height: 12),
          // Customer and Date Row
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoLine(
                'Customer',
                displayCustomerName,
                baseFont,
                boldFont,
                arabicFont,
              ),
              _buildInfoLine(
                'Date',
                DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
                baseFont,
                boldFont,
                arabicFont,
              ),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildInfoLine(
    String label,
    String value,
    pw.Font baseFont,
    pw.Font boldFont,
    pw.Font? arabicFont,
  ) {
    // Check if value contains Arabic/Kurdish characters
    final hasRtlChars = _containsRtlCharacters(value);

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(
            fontSize: 8,
            color: PdfColors.grey600,
            letterSpacing: 1,
            font: baseFont,
          ),
        ),
        pw.Text(
          value,
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.black,
            font: hasRtlChars && arabicFont != null ? arabicFont : boldFont,
          ),
          textDirection: hasRtlChars
              ? pw.TextDirection.rtl
              : pw.TextDirection.ltr,
        ),
      ],
    );
  }

  // Helper to detect RTL characters (Arabic, Kurdish, Hebrew, etc.)
  static bool _containsRtlCharacters(String text) {
    if (text.isEmpty) return false;
    final rtlPattern = RegExp(
      r'[\u0590-\u05FF\u0600-\u06FF\u0700-\u074F\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]',
    );
    return rtlPattern.hasMatch(text);
  }

  static pw.Widget _buildSummary(CustomerAccountStatement statement) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const pw.BoxDecoration(
        color: PdfColor.fromInt(0xFFF5F6FA),
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(8)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          _buildSummaryItem(
            'Initial Loan',
            _formatCurrency(statement.initialLoan),
          ),
          _buildSummaryItem(
            'Current Loan',
            _formatCurrency(statement.currentLoan),
            emphasize: true,
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildPayInsteadSummary(CustomerAccountStatement statement) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const pw.BoxDecoration(
        color: PdfColor.fromInt(0xFFF5F6FA),
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(8)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          _buildSummaryItem(
            'Initial Pay Instead',
            _formatCurrency(statement.initialPayInstead),
          ),
          _buildSummaryItem(
            'Current Pay Instead',
            _formatCurrency(statement.currentPayInstead),
            emphasize: true,
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildStatementTable(
    CustomerAccountStatement statement,
    pw.Font baseFont,
    pw.Font? arabicFont,
  ) {
    final headers = [
      'ID',
      'Container',
      'Origin',
      'Dest',
      'Arrival',
      'Description',
      'Note',
      'Price',
      'Balance',
    ];

    final data = <List<String>>[];

    // Initial Loan Row
    data.add([
      '',
      '',
      '',
      '',
      '',
      'Initial Loan',
      '',
      _formatCurrency(statement.initialLoan),
      _formatCurrency(statement.initialLoan),
    ]);

    for (final item in statement.items) {
      data.add([
        item.id?.toString() ?? '',
        item.container ?? '',
        item.origin ?? '',
        item.destination ?? '',
        _formatDate(item.arrival),
        item.description ?? '',
        item.note ?? '',
        _formatCurrency(item.price),
        _formatCurrency(item.balance),
      ]);
    }

    final alignments = [
      pw.Alignment.center,
      pw.Alignment.centerLeft,
      pw.Alignment.centerLeft,
      pw.Alignment.centerLeft,
      pw.Alignment.centerLeft,
      pw.Alignment.centerLeft,
      pw.Alignment.centerLeft,
      pw.Alignment.centerRight,
      pw.Alignment.centerRight,
    ];

    final rows = <pw.TableRow>[
      _buildTableRow(
        headers,
        alignments,
        isHeader: true,
        baseFont: baseFont,
        arabicFont: arabicFont,
      ),
      _buildTableRow(
        data.first,
        alignments,
        decoration: const pw.BoxDecoration(color: PdfColors.grey200),
        baseFont: baseFont,
        arabicFont: arabicFont,
      ),
    ];

    for (var i = 1; i < data.length; i++) {
      final itemIndex = i - 1;
      final item = statement.items[itemIndex];
      final isPayment = item.isPayment;
      final isExpense = item.isExpense;
      final rowDecoration = isPayment
          ? const pw.BoxDecoration(color: PdfColor.fromInt(0xFFE8F5E9))
          : (isExpense
                ? const pw.BoxDecoration(color: PdfColor.fromInt(0xFFFFEBEE))
                : const pw.BoxDecoration(color: PdfColors.white));

      rows.add(
        _buildTableRow(
          data[i],
          alignments,
          decoration: rowDecoration,
          baseFont: baseFont,
          arabicFont: arabicFont,
        ),
      );
    }

    return pw.Table(
      border: pw.TableBorder.symmetric(
        inside: const pw.BorderSide(color: PdfColors.grey300, width: 0.4),
        outside: const pw.BorderSide(color: PdfColors.grey500, width: 0.8),
      ),
      defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
      columnWidths: {
        0: const pw.FixedColumnWidth(36),
        1: const pw.FixedColumnWidth(55),
        2: const pw.FixedColumnWidth(45),
        3: const pw.FixedColumnWidth(45),
        4: const pw.FixedColumnWidth(60),
        5: const pw.FlexColumnWidth(2),
        6: const pw.FlexColumnWidth(2),
        7: const pw.FixedColumnWidth(70),
        8: const pw.FixedColumnWidth(70),
      },
      children: rows,
    );
  }

  static pw.Widget _buildPayInsteadTable(
    List<CustomerStatementItem> items,
    double initialBalance,
    pw.Font baseFont,
    pw.Font? arabicFont,
  ) {
    final headers = ['ID', 'Container', 'Description', 'Price', 'Balance'];

    final data = <List<String>>[];

    // Initial Row
    data.add([
      '',
      '',
      'Initial PayInstead',
      _formatCurrency(initialBalance),
      _formatCurrency(initialBalance),
    ]);

    for (final item in items) {
      data.add([
        item.id?.toString() ?? '',
        item.container ?? '',
        item.description ?? '',
        _formatCurrency(item.price),
        _formatCurrency(item.balance),
      ]);
    }

    final alignments = [
      pw.Alignment.center,
      pw.Alignment.centerLeft,
      pw.Alignment.centerLeft,
      pw.Alignment.centerRight,
      pw.Alignment.centerRight,
    ];

    final rows = <pw.TableRow>[
      _buildTableRow(
        headers,
        alignments,
        isHeader: true,
        baseFont: baseFont,
        arabicFont: arabicFont,
      ),
      _buildTableRow(
        data.first,
        alignments,
        decoration: const pw.BoxDecoration(color: PdfColors.grey200),
        baseFont: baseFont,
        arabicFont: arabicFont,
      ),
    ];

    for (var i = 1; i < data.length; i++) {
      final decoration = i.isEven
          ? const pw.BoxDecoration(color: PdfColor.fromInt(0xFFF9F9F9))
          : const pw.BoxDecoration(color: PdfColors.white);
      rows.add(
        _buildTableRow(
          data[i],
          alignments,
          decoration: decoration,
          baseFont: baseFont,
          arabicFont: arabicFont,
        ),
      );
    }

    return pw.Table(
      border: pw.TableBorder.symmetric(
        inside: const pw.BorderSide(color: PdfColors.grey300, width: 0.4),
        outside: const pw.BorderSide(color: PdfColors.grey500, width: 0.8),
      ),
      defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
      columnWidths: {
        0: const pw.FixedColumnWidth(28),
        1: const pw.FixedColumnWidth(65),
        2: const pw.FlexColumnWidth(2),
        3: const pw.FixedColumnWidth(70),
        4: const pw.FixedColumnWidth(70),
      },
      children: rows,
    );
  }

  static pw.Widget _buildFooter(CustomerAccountStatement statement) {
    final balance = statement.currentLoan ?? 0;
    final balanceColor = balance >= 0
        ? PdfColor.fromInt(0xFF1B5E20)
        : PdfColor.fromInt(0xFFB71C1C);
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 12),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        children: [
          pw.Divider(),
          pw.Text(
            'Final Balance: ${_formatCurrency(balance)}',
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
              color: balanceColor,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildPayInsteadFooter(CustomerAccountStatement statement) {
    final balance = statement.currentPayInstead ?? 0;
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 12),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        children: [
          pw.Divider(),
          pw.Text(
            'Final Balance: ${_formatCurrency(balance)}',
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.blueGrey900,
            ),
          ),
        ],
      ),
    );
  }

  static Future<String> _savePdf(pw.Document pdf, String namePrefix) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName =
        '${namePrefix}_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.pdf';
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file.path;
  }

  static pw.Widget _buildSummaryItem(
    String label,
    String value, {
    bool emphasize = false,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
        ),
        pw.Text(
          value,
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: emphasize ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        ),
      ],
    );
  }

  static String _formatCurrency(double? value) {
    return _currencyFormat.format(value ?? 0);
  }

  static String _formatDate(DateTime? date) {
    if (date == null) return '';
    return _dateFormat.format(date);
  }

  static Future<pw.Font?> _tryLoadFont(String assetPath) async {
    try {
      final data = await rootBundle.load(assetPath);
      return pw.Font.ttf(data);
    } catch (_) {
      return null;
    }
  }

  static Future<pw.ImageProvider?> _tryLoadImage(String assetPath) async {
    try {
      final data = await rootBundle.load(assetPath);
      final imageBytes = data.buffer.asUint8List();
      final image = pw.MemoryImage(imageBytes);
      return image;
    } catch (e) {
      return null;
    }
  }

  static pw.TableRow _buildTableRow(
    List<String> values,
    List<pw.Alignment> alignments, {
    bool isHeader = false,
    pw.BoxDecoration? decoration,
    pw.Font? baseFont,
    pw.Font? arabicFont,
  }) {
    return pw.TableRow(
      decoration: decoration,
      children: List.generate(values.length, (index) {
        final value = values[index];
        final hasRtlChars = _containsRtlCharacters(value);

        // Description column should have smaller font
        // In Statement table: Description is at index 5
        // In Pay Instead table: Description is at index 2
        final isDescriptionColumn = index == 5 || index == 2;
        final baseFontSize = isDescriptionColumn
            ? 7.0
            : (hasRtlChars ? 8.0 : 9.0);

        // Use Arabic font for RTL text, but always provide base font as fallback
        // This ensures English characters in mixed content can be rendered
        final style = pw.TextStyle(
          fontSize: baseFontSize,
          fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
          color: isHeader ? PdfColors.black : PdfColors.grey800,
          font: hasRtlChars && arabicFont != null ? arabicFont : null,
          // Always include base font as fallback for English characters in mixed content
          fontFallback: hasRtlChars && arabicFont != null && baseFont != null
              ? [baseFont]
              : <pw.Font>[],
        );

        // Adjust alignment for RTL text in table cells
        pw.Alignment cellAlignment = alignments[index];
        if (hasRtlChars && cellAlignment == pw.Alignment.centerLeft) {
          // For RTL text, use centerRight alignment to properly display
          cellAlignment = pw.Alignment.centerRight;
        }

        return pw.Container(
          alignment: cellAlignment,
          padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: pw.Text(
            value,
            style: style,
            maxLines: 3,
            overflow: pw.TextOverflow.span,
            textDirection: hasRtlChars
                ? pw.TextDirection.rtl
                : pw.TextDirection.ltr,
          ),
        );
      }),
    );
  }
}
