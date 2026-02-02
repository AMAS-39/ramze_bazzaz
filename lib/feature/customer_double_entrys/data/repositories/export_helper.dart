import 'dart:io';

import 'package:app/core/shared/imports.dart';
import 'package:app/feature/account/presentation/bloc/account/account_bloc.dart';
import 'package:app/feature/customer_double_entrys/data/models/customer_double_entrys_model.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webcontent_converter/webcontent_converter.dart';

String _getRow(CustomerDoubleEntryModel item) {
  return '''
 <tr>
        <td>${item.transferAmount.format}</td>
        <td>${item.commission.format}</td>
        <td>${item.totalTransferAmount.format}</td>
        <td>${item.exchangeRate.format}</td>
        <td>${item.price.format}</td>
        <td>${item.expensePrice.format}</td>
        <td>${item.otherPrice.format}</td>
        <td>${(item.isLost ? (item.totalPrice + item.forgivePrice) : -(item.totalPrice + item.forgivePrice)).format}</td>
        <td>${item.date.onlyDate}</td>
        <td>${item.shopNumber ?? ""}</td>
        <td>${item.isLost ? item.shopName : item.invoiceNumber}</td>
        <td></td>
        <td></td>
    </tr>
''';
}

String _geenrateRows(List<CustomerDoubleEntryModel> data) {
  return data.map((e) => _getRow(e)).join("\n");
}

String _geenrateOuter(List<CustomerDoubleEntryModel> data) {
  return '''
 <tr class="outHeader">
          <td>${data.fold(0.0, (x, c) => x + c.transferAmount).format} ¥</td>
          <td></td>
          <td>${data.fold(0.0, (x, c) => x + c.totalTransferAmount).format} ¥</td>
          <td></td>
          <td>${data.fold(0.0, (x, c) => x + c.price).format}</td>
          <td colspan="2">${data.fold(0.0, (c, x) => x.totalTransferAmount + c)}</td>
          <td>${data.fold(0.0, (c, x) => c + (x.isLost ? (x.totalPrice + x.forgivePrice) : -(x.totalPrice + x.forgivePrice)))}</td>
          <td colspan="6">
              <p>
                  علامة (-) تاجر باقي حسابه عند شركة
                  &nbsp; || &nbsp;
                  علامة (+) تاجر يدين لشركة
              </p>
          </td>
  </tr>

''';
}

Future<String> exportToPDF(
    List<CustomerDoubleEntryModel> data, bool returnContent) async {
  if (data.isEmpty) {
    return "";
  }
  showLoadingProgressAlert();
  final content = getWhole(_geenrateRows(data), _geenrateOuter(data));

  Helper.i.context.pop();
  return content;
}

String getWhole(String rows, String outer) {
  return '''
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <style>
        bbody {
            padding: 0rem;
            margin: 0;
            box-sizing: border-box;
            min-height: 8.27in;
            /* max-width: 11.69in; */
            font-family: "Noto Sans", Arial, Helvetica, sans-serif;
        }

        p,
        h1,
        h2,
        h3,
        h4,
        h5,
        h6 {
            margin: 0;
        }

        .h5 {
            font-size: 0.83em !important;
        }

        .header p {
            font-size: 80%;
        }

        .header {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
        }

        .header .right,
        .header .left {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: start;
            gap: 0.5rem;
        }

        .header .logo_container {
            text-align: center;
        }

        .header .logo {
            width: 10rem;
        }

        /* Table design */
        .table_container {
            /* display: flex; */
            justify-content: center;
            width: 100%;
        }

        table {
            border-collapse: collapse;
            table-layout: auto;
            width: 100%;
            margin-bottom: 0px !important;
        }

        table,
        th,
        td {
            border: 1px solid rgb(92, 92, 92);
            padding: 0.4rem;
        }

        thead,
        tfoot,
        tbody tr td:nth-child(3),
        td:nth-child(8) {
            background-color: rgb(255, 244, 195);
        }

        th,
        td {
            font-weight: 400;
            font-size: 65%;
        }

        .outHeader {
            background-color: rgb(255, 244, 195);
        }

        @page {
            @bottom-left {
                content: counter(page) "/" counter(pages);
            }
        }
    </style>
</head>

<body>
    <div dir="rtl" class="bbody" id="content">
        <!-- !Header -->
        <div class="header" style="font-size:0.83em !important">
            <div class="right">
                <p>شركة رمزی بزاز للتجارة العامة و النقل</p>
                <p>كۆمپانیای ڕەمزی بەزاز بۆ بازرگانی گشتی و گواستنەوە</p>
                <p>هەولێر - ڤانە مۆل - نھۆمی دووەم - ژمارە E12</p>
                <p dir="ltr">0750 433 8848 - 0750 314 4911</p>
                <hr style="border: 1px solid black; width: 100%" />
                <p style="font-size:15px">${sl<AccountBloc>().info?.fullName} - حساب</p>
            </div>
            <div class="logo_container">
                <img src="https://i.ibb.co/HqW5bkx/rbbColor.png" alt="" class="logo" />
            </div>
            <div class="left" dir="ltr">
                <p style="font-weight: 500">RAMZE BAZZAZ Trading Co., Ltd.</p>
                <p><strong> Tel CN: </strong> 0086-020-61205016</p>
                <p><strong>Mobile EBL: </strong> 00964-7504338848</p>
                <p><strong>Mobile CN: </strong> 0086-13822254030</p>
                <p><strong>Email: </strong> ramzebazzazcompany@hotmail.com</p>
                <p><strong>Email: </strong> ramzebazzazarbil@hotmail.com</p>
                <p>
                    <strong>Add: </strong> China, Guangzhou, Jianshe 6th Rd., Yian
                    Palaza, Room 1703
                </p>
            </div>
        </div>
        <!-- !Table -->
        <div class="table_container">
            <table class="table" dir="ltr">
                <tbody>
                    <tr class="outHeader">
                        <th colspan="14">
                            <strong>
                                شركة رمزی البزاز لیس مسؤل عن تأخیر حاویات ما الصین او
                                الامارات او تركیا او ایران ولیس مسۆول عن اغلاق المیناء او
                                الحدود من قبل الحكومة
                            </strong>
                        </th>
                    </tr>
                    <tr class="outHeader">
                        <th colspan="14">
                            <strong>
                                ولیس مسؤل عن تغیر أیقرارات الحكومیة من قبل حكومة (المركزیة او
                                الاقلیم) (الغرامات و الضرائب والكمرك والمواد ممنوعة) - التاجر
                                ھو مسؤل علیە
                            </strong>
                        </th>
                    </tr>
                    <tr class="outHeader">
                        <th>Amount ¥</th>
                        <th>C.C. %</th>
                        <th>Total ¥</th>
                        <th>Price ¥</th>
                        <th>Amount \$</th>
                        <th>T.C. \$</th>
                        <th>O.Amount \$</th>
                        <th>Total \$</th>
                        <th>Date</th>
                        <th>Shop No</th>
                        <th>Shop/Invoice</th>
                        <th>Write Total</th>
                        <th>Carton</th>

                    </tr>
                    $rows
                    <!--Footer-->
                     $outer
                </tbody>
                <tfoot style="text-align: center">
                </tfoot>
            </table>
        </div>

    </div>
</body>

</html>

''';
}

Future<void> saveHtmlAsPdf(String content, String fileName, bool share) async {
  try {
    logger(content);
    Directory? downloadsDirectory;
    if (Platform.isAndroid) {
      downloadsDirectory = await DownloadsPath.downloadsDirectory();
    } else {
      downloadsDirectory = await getApplicationDocumentsDirectory();
    }
    var savedPath =
        "${downloadsDirectory?.path}/$fileName${DateTime.now().millisecond}.pdf";
    var result = await saveInSolate(
        ExportIsolateParams(content: content, savedPath: savedPath));
    showSuccessFlashBar(Trans.fileWasSaved.trans());
    logger("result $result");
  } catch (e) {
    logger("error $e");
  }
}

class ExportIsolateParams {
  final String savedPath, content;

  ExportIsolateParams({required this.content, required this.savedPath});
}

Future<String?> saveInSolate(ExportIsolateParams p) async {
  WebcontentConverter();
  WebcontentConverter.ensureInitialized();
  var result = await WebcontentConverter.contentToPDF(
    content: p.content,
    savedPath: p.savedPath,
    format: const PaperFormat.inches(height: 8.27, width: 11.7),
    margins: PdfMargins.px(top: 20, bottom: 20, right: 20, left: 20),
    executablePath: WebViewHelper.executablePath(),
  );
  return result;
}
/*

async Task Refresh()
    {
        try
        {
            isBusy = true;
            var response = await MyHttpService.GetListAsync<CustomerDoubleEntryDto>(_httpClient, ApiRoutes.CustomerDoubleEntriesRoute + $"?end=1000&id={Id}&sort=id&order=asc&setNumber={SetNumber}");
            payInstead = response.Entries ?? new();
            totalCount = response.TotalCount;
            totalSets = response.TotalSets;
            setItems.Clear();
            for (int i = -1; i < totalSets; i++)
            {
                setItems.Add(i + 1);
            }
            if (AuthService.GetTenantName() == "RBB")
                if (setItems.Contains(0))
                {
                    setItems.Remove(0);
                }


            // payInstead = await _httpClient.GetFromJsonAsync<List<CustomerDoubleEntryDto>>(ApiRoutes.CustomerDoubleEntriesRoute + $"?end=1000&id={currentCustomer.Id}&sort=id&order=asc&setNumber={SetNumber}", Helpers.MyHelpers.MyJsonOptions()) ?? new();
            if (payInstead.Count > 0)
                payInstead[0].Balance = payInstead[0].IsLost ? payInstead[0].TotalPrice : -payInstead[0].TotalPrice;
            if (payInstead.Count > 1)
            {
                for (int i = 1; i < payInstead.Count; i++)
                {
                    payInstead[i].Balance = payInstead[i].IsLost ? payInstead[i - 1].Balance + payInstead[i].TotalPrice : payInstead[i - 1].Balance - payInstead[i].TotalPrice;
                }
            }
             ToWord paidPriceToWord = new ToWord(payInstead.Sum(x => x.TotalTransferAmount), new CurrencyInfo(CurrencyInfo.Currencies.USD), false);
             paidTextPrice = "تەنها " + paidPriceToWord.ConvertToKurdish(false) + $" {("رممبی")}";
        }
        catch (Exception ex)
        {
            await MyHelpers.FireErrorSwal(Swal, ex.Message);
            Console.WriteLine(ex.Message);
        }
        finally
        {
            isBusy = false;
            StateHasChanged();
        }
    }

 */