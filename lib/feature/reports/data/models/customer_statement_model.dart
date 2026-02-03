import 'dart:convert';

import 'package:app/core/shared/imports.dart';
import 'package:equatable/equatable.dart';

/// One line in a customer statement (ledger entry).
class CustomerStatementItem extends Equatable {
  final int? id;
  final String? container;
  final String? origin;
  final String? destination;
  final DateTime? arrival;
  final String? description;
  final String? note;
  final double? price;
  final double? balance;
  final double? deposit;
  final double? withdraw;
  final bool? isWithdraw;

  const CustomerStatementItem({
    this.id,
    this.container,
    this.origin,
    this.destination,
    this.arrival,
    this.description,
    this.note,
    this.price,
    this.balance,
    this.deposit,
    this.withdraw,
    this.isWithdraw,
  });

  /// Resolved amount for display: withdraw/expense positive, deposit/payment negative.
  double get amount {
    if (withdraw != null && (withdraw ?? 0) != 0) return withdraw!;
    if (deposit != null && (deposit ?? 0) != 0) return -deposit!;
    if (price != null && (price ?? 0) != 0) {
      if (isWithdraw == true) return price!;
      return -price!;
    }
    return 0;
  }

  /// True if description suggests expense (expense, package, loan).
  bool get isExpense {
    final d = (description ?? '').toLowerCase();
    return d.contains('expense') || d.contains('package') || d.contains('loan');
  }

  /// True if description suggests payment (payment, return).
  bool get isPayment {
    final d = (description ?? '').toLowerCase();
    return d.contains('payment') || d.contains('return');
  }

  static double _parseDouble(dynamic v, {double def = 0}) {
    if (v == null) return def;
    return checkDouble(v, defaultV: def);
  }

  static int? _parseInt(dynamic v) {
    if (v == null) return null;
    return checkInt(v, defaultV: 0);
  }

  static DateTime? _parseDate(dynamic v) {
    if (v == null) return null;
    if (v is DateTime) return v;
    final s = '$v'.trim();
    if (s.isEmpty) return null;
    return DateTime.tryParse(s);
  }

  static String? _str(dynamic v) {
    if (v == null) return null;
    final s = '$v'.trim();
    return s.isEmpty ? null : s;
  }

  static T? _getKey<T>(Map<String, dynamic> json, List<String> keys, T? Function(dynamic) parse) {
    final lower = json.map((k, v) => MapEntry(k.toString().toLowerCase(), v));
    for (final k in keys) {
      final v = lower[k.toLowerCase()];
      if (v != null) return parse(v);
    }
    return null;
  }

  factory CustomerStatementItem.fromJson(Map<String, dynamic> json) {
    final lower = json.map((k, v) => MapEntry(k.toString().toLowerCase(), v));
    int? id = _getKey(json, ['id', 'entryid', 'itemid', 'recordid', 'statementid', 'invoiceid'], (v) => _parseInt(v));
    if (id == null && lower['id'] != null) id = _parseInt(lower['id']);

    String? container = _getKey(json, ['container', 'containernumber', 'container_no', 'containerno'], (v) => _str(v));
    String? origin = _getKey(json, ['origin', 'originname', 'origin_country', 'from', 'fromcountry'], (v) => _str(v));
    String? destination = _getKey(json, ['destination', 'destinationname', 'to', 'tocountry'], (v) => _str(v));
    DateTime? arrival = _getKey(json, ['arrival', 'arrivaldate', 'arrival_date', 'date'], (v) => _parseDate(v));
    String? description = _getKey(json, ['description', 'details', 'title', 'statement', 'type'], (v) => _str(v));
    String? note = _getKey(json, ['note', 'notes', 'remark', 'remarks', 'details'], (v) => _str(v));

    double? price = _getKey(json, ['price', 'pricevalue', 'amount', 'totalamount', 'debit', 'credit'], (v) => _parseDouble(v));
    double? balance = _getKey(json, ['balance', 'balancevalue', 'currentbalance', 'loanbalance', 'loan'], (v) => _parseDouble(v));
    double? deposit = _getKey(json, ['deposit', 'credit', 'creditamount', 'depositamount'], (v) => _parseDouble(v));
    double? withdraw = _getKey(json, ['withdraw', 'debit', 'withdrawamount'], (v) => _parseDouble(v));
    bool? isWithdraw = _getKey(json, ['iswithdraw', 'is_withdraw', 'isexpense'], (v) {
      if (v == null) return null;
      return checkBool(v);
    });

    return CustomerStatementItem(
      id: id,
      container: container,
      origin: origin,
      destination: destination,
      arrival: arrival,
      description: description,
      note: note,
      price: price,
      balance: balance,
      deposit: deposit,
      withdraw: withdraw,
      isWithdraw: isWithdraw,
    );
  }

  CustomerStatementItem copyWith({
    int? id,
    String? container,
    String? origin,
    String? destination,
    DateTime? arrival,
    String? description,
    String? note,
    double? price,
    double? balance,
    double? deposit,
    double? withdraw,
    bool? isWithdraw,
  }) {
    return CustomerStatementItem(
      id: id ?? this.id,
      container: container ?? this.container,
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      arrival: arrival ?? this.arrival,
      description: description ?? this.description,
      note: note ?? this.note,
      price: price ?? this.price,
      balance: balance ?? this.balance,
      deposit: deposit ?? this.deposit,
      withdraw: withdraw ?? this.withdraw,
      isWithdraw: isWithdraw ?? this.isWithdraw,
    );
  }

  @override
  List<Object?> get props => [id, container, origin, destination, arrival, description, note, price, balance, deposit, withdraw, isWithdraw];
}

/// Full statement (account or pay-instead) with summary and items.
class CustomerAccountStatement extends Equatable {
  final String? customerName;
  final double? initialLoan;
  final double? currentLoan;
  final double? initialPayInstead;
  final double? currentPayInstead;
  final List<CustomerStatementItem> items;

  const CustomerAccountStatement({
    this.customerName,
    this.initialLoan,
    this.currentLoan,
    this.initialPayInstead,
    this.currentPayInstead,
    required this.items,
  });

  static List<CustomerStatementItem> _parseItems(Map<String, dynamic> json) {
    final lower = json.map((k, v) => MapEntry(k.toString().toLowerCase(), v));
    List<dynamic>? raw;
    raw = lower['items'] as List<dynamic>?;
    raw ??= lower['entries'] as List<dynamic>?;
    raw ??= lower['data'] as List<dynamic>?;
    raw ??= lower['doubleentries'] as List<dynamic>?;
    raw ??= lower['customerdoubleentries'] as List<dynamic>?;
    if (raw == null) {
      for (final entry in lower.entries) {
        if (entry.value is List) {
          raw = entry.value as List<dynamic>;
          break;
        }
      }
    }
    if (raw == null || raw.isEmpty) return [];
    return raw
        .map((e) => CustomerStatementItem.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  static String? _customerNameFromJson(Map<String, dynamic> json) {
    final lower = json.map((k, v) => MapEntry(k.toString().toLowerCase(), v));
    final keys = ['customername', 'customer_name', 'fullname', 'name', 'fullName'];
    for (final k in keys) {
      final v = lower[k];
      if (v != null && v is String) {
        final s = v.trim();
        if (s.isEmpty) continue;
        if (looksLikeUsername(s)) continue;
        return s;
      }
    }
    return null;
  }

  /// True if string looks like a username (short, no spaces) — avoid using as display name.
  static bool looksLikeUsername(String s) {
    if (s.length < 3) return true;
    if (s.contains(' ')) return false;
    if (RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(s) && s.length <= 32) return true;
    return false;
  }

  factory CustomerAccountStatement.fromJson(Map<String, dynamic> json) {
    final lower = json.map((k, v) => MapEntry(k.toString().toLowerCase(), v));
    final customerName = _customerNameFromJson(json);
    double? initialLoan = _getDouble(lower, ['initialloan', 'initial_loan', 'initialloantext', 'initialloanusd']);
    double? currentLoan = _getDouble(lower, ['currentloan', 'current_loan', 'currentloantext', 'currentloanusd']);
    double? initialPayInstead = _getDouble(lower, ['initialpayinstead', 'initial_pay_instead']);
    double? currentPayInstead = _getDouble(lower, ['currentpayinstead', 'current_pay_instead']);
    final items = _parseItems(json);
    return CustomerAccountStatement(
      customerName: customerName,
      initialLoan: initialLoan,
      currentLoan: currentLoan,
      initialPayInstead: initialPayInstead,
      currentPayInstead: currentPayInstead,
      items: items,
    );
  }

  static double? _getDouble(Map<String, dynamic> lower, List<String> keys) {
    for (final k in keys) {
      final v = lower[k];
      if (v != null) return checkDouble(v);
    }
    return null;
  }

  @override
  List<Object?> get props => [customerName, initialLoan, currentLoan, initialPayInstead, currentPayInstead, items];
}
