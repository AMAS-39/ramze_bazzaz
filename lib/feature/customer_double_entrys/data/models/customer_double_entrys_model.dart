import 'dart:convert';

import 'package:app/core/shared/imports.dart';

class CustomerDoubleEntryModel extends Equatable {
  final String? title;
  final String? description;
  final String? invoiceNumber;
  final String? idempotentToken;
  final String? attachment;
  final DateTime date;
  final double transferAmount;
  final String? currency;
  final double commission;
  final double otherAmount;
  final double totalTransferAmount;
  final bool takeFromScSafebox;
  final double exchangeRate;
  final double cost;
  final double scCost;
  final double price;
  final double scPrice;
  final double forgivePrice;
  final double scForgivePrice;
  final bool byMain;
  final double expensePrice;
  final double scExpensePrice;
  final double otherPrice;
  final double scOtherPrice;
  final double totalPrice;
  final double scTotalPrice;
  final int sort;
  final int setNumber;
  final String? bgColor;
  final String? safeboxName;
  final int safeboxId;
  final String? customerName;
  final String? customerCode;
  final int customerId;
  final String? paidBy;
  final String? accountant;
  final String? shopNumber;
  final String? shopName;
  final String? shopDetail;
  final String? shopNote;
  final bool isLost;
  final String? note;
  final double balance;
  final double scBalance;
  final int id;
  const CustomerDoubleEntryModel({
    required this.title,
    required this.description,
    required this.invoiceNumber,
    required this.idempotentToken,
    required this.attachment,
    required this.date,
    required this.transferAmount,
    required this.currency,
    required this.commission,
    required this.otherAmount,
    required this.totalTransferAmount,
    required this.takeFromScSafebox,
    required this.exchangeRate,
    required this.cost,
    required this.scCost,
    required this.price,
    required this.scPrice,
    required this.forgivePrice,
    required this.scForgivePrice,
    required this.byMain,
    required this.expensePrice,
    required this.scExpensePrice,
    required this.otherPrice,
    required this.scOtherPrice,
    required this.totalPrice,
    required this.scTotalPrice,
    required this.sort,
    required this.setNumber,
    required this.bgColor,
    required this.safeboxName,
    required this.safeboxId,
    required this.customerName,
    required this.customerCode,
    required this.customerId,
    required this.paidBy,
    required this.accountant,
    required this.shopNumber,
    required this.shopName,
    required this.shopDetail,
    required this.shopNote,
    required this.isLost,
    required this.note,
    required this.balance,
    required this.scBalance,
    required this.id,
  });

  CustomerDoubleEntryModel copyWith({
    String? title,
    String? description,
    String? invoiceNumber,
    String? idempotentToken,
    String? attachment,
    DateTime? date,
    double? transferAmount,
    String? currency,
    double? commission,
    double? otherAmount,
    double? totalTransferAmount,
    bool? takeFromScSafebox,
    double? exchangeRate,
    double? cost,
    double? scCost,
    double? price,
    double? scPrice,
    double? forgivePrice,
    double? scForgivePrice,
    bool? byMain,
    double? expensePrice,
    double? scExpensePrice,
    double? otherPrice,
    double? scOtherPrice,
    double? totalPrice,
    double? scTotalPrice,
    int? sort,
    int? setNumber,
    String? bgColor,
    String? safeboxName,
    int? safeboxId,
    String? customerName,
    String? customerCode,
    int? customerId,
    String? paidBy,
    String? accountant,
    String? shopNumber,
    String? shopName,
    String? shopDetail,
    String? shopNote,
    bool? isLost,
    String? note,
    double? balance,
    double? scBalance,
    int? id,
  }) {
    return CustomerDoubleEntryModel(
      title: title ?? this.title,
      description: description ?? this.description,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      idempotentToken: idempotentToken ?? this.idempotentToken,
      attachment: attachment ?? this.attachment,
      date: date ?? this.date,
      transferAmount: transferAmount ?? this.transferAmount,
      currency: currency ?? this.currency,
      commission: commission ?? this.commission,
      otherAmount: otherAmount ?? this.otherAmount,
      totalTransferAmount: totalTransferAmount ?? this.totalTransferAmount,
      takeFromScSafebox: takeFromScSafebox ?? this.takeFromScSafebox,
      exchangeRate: exchangeRate ?? this.exchangeRate,
      cost: cost ?? this.cost,
      scCost: scCost ?? this.scCost,
      price: price ?? this.price,
      scPrice: scPrice ?? this.scPrice,
      forgivePrice: forgivePrice ?? this.forgivePrice,
      scForgivePrice: scForgivePrice ?? this.scForgivePrice,
      byMain: byMain ?? this.byMain,
      expensePrice: expensePrice ?? this.expensePrice,
      scExpensePrice: scExpensePrice ?? this.scExpensePrice,
      otherPrice: otherPrice ?? this.otherPrice,
      scOtherPrice: scOtherPrice ?? this.scOtherPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      scTotalPrice: scTotalPrice ?? this.scTotalPrice,
      sort: sort ?? this.sort,
      setNumber: setNumber ?? this.setNumber,
      bgColor: bgColor ?? this.bgColor,
      safeboxName: safeboxName ?? this.safeboxName,
      safeboxId: safeboxId ?? this.safeboxId,
      customerName: customerName ?? this.customerName,
      customerCode: customerCode ?? this.customerCode,
      customerId: customerId ?? this.customerId,
      paidBy: paidBy ?? this.paidBy,
      accountant: accountant ?? this.accountant,
      shopNumber: shopNumber ?? this.shopNumber,
      shopName: shopName ?? this.shopName,
      shopDetail: shopDetail ?? this.shopDetail,
      shopNote: shopNote ?? this.shopNote,
      isLost: isLost ?? this.isLost,
      note: note ?? this.note,
      balance: balance ?? this.balance,
      scBalance: scBalance ?? this.scBalance,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'invoiceNumber': invoiceNumber,
      'idempotentToken': idempotentToken,
      'attachment': attachment,
      'date': date.toIso8601String(),
      'transferAmount': transferAmount,
      'currency': currency,
      'commission': commission,
      'otherAmount': otherAmount,
      'totalTransferAmount': totalTransferAmount,
      'takeFromScSafebox': takeFromScSafebox,
      'exchangeRate': exchangeRate,
      'cost': cost,
      'scCost': scCost,
      'price': price,
      'scPrice': scPrice,
      'forgivePrice': forgivePrice,
      'scForgivePrice': scForgivePrice,
      'byMain': byMain,
      'expensePrice': expensePrice,
      'scExpensePrice': scExpensePrice,
      'otherPrice': otherPrice,
      'scOtherPrice': scOtherPrice,
      'totalPrice': totalPrice,
      'scTotalPrice': scTotalPrice,
      'sort': sort,
      'setNumber': setNumber,
      'bgColor': bgColor,
      'safeboxName': safeboxName,
      'safeboxId': safeboxId,
      'customerName': customerName,
      'customerCode': customerCode,
      'customerId': customerId,
      'paidBy': paidBy,
      'accountant': accountant,
      'shopNumber': shopNumber,
      'shopName': shopName,
      'shopDetail': shopDetail,
      'shopNote': shopNote,
      'isLost': isLost,
      'note': note,
      'balance': balance,
      'scBalance': scBalance,
      'id': id,
    };
  }

  factory CustomerDoubleEntryModel.fromMap(Map<String, dynamic> map) {
    return CustomerDoubleEntryModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      invoiceNumber: map['invoiceNumber'] ?? '',
      idempotentToken: map['idempotentToken'] ?? '',
      attachment: map['attachment'] ?? '',
      date: DateTime.parse(map['date']),
      transferAmount: checkDouble(map['transferAmount']),
      currency: map['currency'] ?? '',
      commission: checkDouble(map['commission']),
      otherAmount: checkDouble(map['otherAmount']),
      totalTransferAmount: checkDouble(map['totalTransferAmount']),
      takeFromScSafebox: checkBool(map['takeFromScSafebox']),
      exchangeRate: checkDouble(map['exchangeRate']),
      cost: checkDouble(map['cost']),
      scCost: checkDouble(map['scCost']),
      price: checkDouble(map['price']),
      scPrice: checkDouble(map['scPrice']),
      forgivePrice: checkDouble(map['forgivePrice']),
      scForgivePrice: checkDouble(map['scForgivePrice']),
      byMain: checkBool(map['byMain']),
      expensePrice: checkDouble(map['expensePrice']),
      scExpensePrice: checkDouble(map['scExpensePrice']),
      otherPrice: checkDouble(map['otherPrice']),
      scOtherPrice: checkDouble(map['scOtherPrice']),
      totalPrice: checkDouble(map['totalPrice']),
      scTotalPrice: checkDouble(map['scTotalPrice']),
      sort: map['sort']?.toInt() ?? 0,
      setNumber: map['setNumber']?.toInt() ?? 0,
      bgColor: map['bgColor'] ?? '',
      safeboxName: map['safeboxName'] ?? '',
      safeboxId: map['safeboxId']?.toInt() ?? 0,
      customerName: map['customerName'] ?? '',
      customerCode: map['customerCode'] ?? '',
      customerId: map['customerId']?.toInt() ?? 0,
      paidBy: map['paidBy'] ?? '',
      accountant: map['accountant'] ?? '',
      shopNumber: map['shopNumber'] ?? '',
      shopName: map['shopName'] ?? '',
      shopDetail: map['shopDetail'] ?? '',
      shopNote: map['shopNote'] ?? '',
      isLost: checkBool(map['isLost']),
      note: map['note'] ?? '',
      balance: checkDouble(map['balance']),
      scBalance: checkDouble(map['scBalance']),
      id: map['id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerDoubleEntryModel.fromJson(String source) =>
      CustomerDoubleEntryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CustomerDoubleEntryModel(title: $title, description: $description, invoiceNumber: $invoiceNumber, idempotentToken: $idempotentToken, attachment: $attachment, date: $date, transferAmount: $transferAmount, currency: $currency, commission: $commission, otherAmount: $otherAmount, totalTransferAmount: $totalTransferAmount, takeFromScSafebox: $takeFromScSafebox, exchangeRate: $exchangeRate, cost: $cost, scCost: $scCost, price: $price, scPrice: $scPrice, forgivePrice: $forgivePrice, scForgivePrice: $scForgivePrice, byMain: $byMain, expensePrice: $expensePrice, scExpensePrice: $scExpensePrice, otherPrice: $otherPrice, scOtherPrice: $scOtherPrice, totalPrice: $totalPrice, scTotalPrice: $scTotalPrice, sort: $sort, setNumber: $setNumber, bgColor: $bgColor, safeboxName: $safeboxName, safeboxId: $safeboxId, customerName: $customerName, customerCode: $customerCode, customerId: $customerId, paidBy: $paidBy, accountant: $accountant, shopNumber: $shopNumber, shopName: $shopName, shopDetail: $shopDetail, shopNote: $shopNote, isLost: $isLost, note: $note, balance: $balance, scBalance: $scBalance, id: $id)';
  }

  @override
  List<Object?> get props {
    return [
      title,
      description,
      invoiceNumber,
      idempotentToken,
      attachment,
      date,
      transferAmount,
      currency,
      commission,
      otherAmount,
      totalTransferAmount,
      takeFromScSafebox,
      exchangeRate,
      cost,
      scCost,
      price,
      scPrice,
      forgivePrice,
      scForgivePrice,
      byMain,
      expensePrice,
      scExpensePrice,
      otherPrice,
      scOtherPrice,
      totalPrice,
      scTotalPrice,
      sort,
      setNumber,
      bgColor,
      safeboxName,
      safeboxId,
      customerName,
      customerCode,
      customerId,
      paidBy,
      accountant,
      shopNumber,
      shopName,
      shopDetail,
      shopNote,
      isLost,
      note,
      balance,
      scBalance,
      id,
    ];
  }
}
