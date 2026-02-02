import 'dart:convert';

import 'package:app/core/shared/imports.dart';

class PayInsteadModel extends Equatable {
  final int id;
  final String? title;
  final String? description;
  final String? invoiceNumber;
  final String? safeboxName;
  final String? shopName;
  final String? attachment;
  final DateTime date;
  final double price;
  final double transferAmount;
  final double forgivePrice;
  final double totalTransferAmount;
  final double exchangeRate;
  final double expensePrice;
  final double commission;
  // final double cbm;
  final double otherPrice;
  final double totalPrice;
  final String? customerName;
  final int customerId;
  final String? merchantName;
  final String? accountant;
  final String? shopNo;
  final bool isLost;
  const PayInsteadModel({
    required this.id,
    this.title,
    this.description,
    required this.invoiceNumber,
    required this.safeboxName,
    required this.shopNo,
    this.attachment,
    required this.date,
    required this.price,
    required this.expensePrice,
    required this.transferAmount,
    required this.forgivePrice,
    required this.totalTransferAmount,
    required this.exchangeRate,
    required this.otherPrice,
    required this.totalPrice,
    required this.customerName,
    required this.customerId,
    required this.commission,
    // required this.cbm,
    this.merchantName,
    this.shopName,
    required this.accountant,
    required this.isLost,
  });

  PayInsteadModel copyWith({
    int? id,
    String? title,
    String? description,
    String? shopNo,
    String? invoiceNumber,
    String? attachment,
    DateTime? date,
    double? price,
    double? transferAmount,
    double? totalTransferAmount,
    double? exchangeRate,
    double? expensePrice,
    double? otherPrice,
    double? commission,
    double? forgivePrice,
    // double? cbm,
    double? totalPrice,
    String? customerName,
    String? shopName,
    int? customerId,
    String? merchantName,
    String? accountant,
    String? safeboxName,
    bool? isLost,
  }) {
    return PayInsteadModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      safeboxName: safeboxName ?? this.safeboxName,
      attachment: attachment ?? this.attachment,
      date: date ?? this.date,
      price: price ?? this.price,
      forgivePrice: forgivePrice ?? this.forgivePrice,
      expensePrice: expensePrice ?? this.expensePrice,
      transferAmount: transferAmount ?? this.transferAmount,
      totalTransferAmount: totalTransferAmount ?? this.totalTransferAmount,
      exchangeRate: exchangeRate ?? this.exchangeRate,
      shopName: shopName ?? this.shopName,
      otherPrice: otherPrice ?? this.otherPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      customerName: customerName ?? this.customerName,
      customerId: customerId ?? this.customerId,
      merchantName: merchantName ?? this.merchantName,
      shopNo: shopNo ?? this.shopNo,
      accountant: accountant ?? this.accountant,
      isLost: isLost ?? this.isLost,
      commission: commission ?? this.commission,
      // cbm: cbm ?? this.cbm,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'invoiceNumber': invoiceNumber,
      'attachment': attachment,
      'date': date.toIso8601String(),
      'price': price,
      'transferAmount': transferAmount,
      'totalTransferAmount': totalTransferAmount,
      'exchangeRate': exchangeRate,
      'expensePrice': expensePrice,
      'otherPrice': otherPrice,
      'totalPrice': totalPrice,
      'customerName': customerName,
      'customerId': customerId,
      'safeboxName': safeboxName,
      'shopName': shopName,
      'merchantName': merchantName,
      'forgivePrice': forgivePrice,
      'shopNo': shopNo,
      'commission': commission,
      // 'cbm': cbm,
      'accountant': accountant,
      'isLost': isLost,
    };
  }

  factory PayInsteadModel.fromMap(Map<String, dynamic> map) {
    return PayInsteadModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'],
      description: map['description'],
      invoiceNumber: map['invoiceNumber'],
      shopName: map['shopName'],
      safeboxName: map['safeboxName'],
      attachment: formatAttachment(map['attachment']),
      date: DateTime.parse(map['date']),
      price: checkDouble(map['unitprice'] ?? map['unit_price'] ?? map['scprice'] ?? map['price']),
      expensePrice: checkDouble(map['expensePrice']),
      otherPrice: checkDouble(map['otherPrice']),
      commission: checkDouble(map['commission']),
      transferAmount: checkDouble(map['transferAmount']),
      totalTransferAmount: checkDouble(map['totalTransferAmount']),
      forgivePrice: checkDouble(map['forgivePrice']),
      exchangeRate: checkDouble(map['exchangeRate']),
      // cbm: checkDouble(map['cbm']),
      totalPrice: checkDouble(map['totalPrice']),
      customerName: map['customerName'] ?? '',
      customerId: map['customerId']?.toInt() ?? 0,
      merchantName: map['merchantName'],
      shopNo: map['shopNo'],
      accountant: map['accountant'],
      isLost: checkBool(map['isLost']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PayInsteadModel.fromJson(String source) =>
      PayInsteadModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PayInsteadModel(commission:$commission, safeboxName: $safeboxName,id: $id, title: $title, description: $description, invoiceNumber: $invoiceNumber, attachment: $attachment, date: $date, price: $price, expensePrice: $expensePrice, otherPrice: $otherPrice, totalPrice: $totalPrice, customerName: $customerName, customerId: $customerId, merchantName: $merchantName, accountant: $accountant, isLost: $isLost)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      title,
      description,
      commission,
      // cbm,
      safeboxName,
      invoiceNumber,

      transferAmount,
      totalTransferAmount,
      exchangeRate,
      attachment,
      shopNo,
      date,
      price,
      expensePrice,
      otherPrice,
      totalPrice,
      customerName,
      customerId,
      merchantName,
      accountant,
      isLost,
    ];
  }
}


/*
C.C. => Commission
Amount => Price
T.C. => ExpensePrice
O.Amount => OtherPrice
Total => (item.IsLost ? item.TotalPrice : -item.TotalPrice).ToString("N2")
TotalPrice = CBM * Price + ExtraPrice
 */