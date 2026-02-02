import 'package:app/core/shared/imports.dart';

class PaymentModel extends Equatable {
  final int id;
  final String? note;
  final DateTime date;
  final double price;
  final double forgivePrice;
  final double scPrice;
  final double scForgivePrice;
  final bool byMain;
  final int sort;
  final int setNumber;
  final String? description;
  final String? paidBy;
  final String? accountant;
  final String? fileType;
  final String? attachment;
  final String? idempotentToken;
  final String? customerName;
  final double customerCurrentLoan;
  final int customerId;
  final String? invoiceNumber;
  final String? safeboxName;
  final int safeboxId;
  final String? payType;
  final bool isTransferredToCash;
  final String? kuPriceText;
  final String? arPriceText;
  final String? enPriceText;

  const PaymentModel({
    required this.id,
    required this.note,
    required this.date,
    required this.price,
    required this.forgivePrice,
    required this.scPrice,
    required this.scForgivePrice,
    required this.byMain,
    required this.sort,
    required this.setNumber,
    required this.description,
    required this.paidBy,
    required this.accountant,
    required this.fileType,
    required this.attachment,
    required this.idempotentToken,
    required this.customerName,
    required this.customerCurrentLoan,
    required this.customerId,
    required this.invoiceNumber,
    required this.safeboxName,
    required this.safeboxId,
    required this.payType,
    required this.isTransferredToCash,
    required this.kuPriceText,
    required this.arPriceText,
    required this.enPriceText,
  });

  PaymentModel copyWith({
    int? id,
    String? note,
    DateTime? date,
    double? price,
    double? forgivePrice,
    double? scPrice,
    double? scForgivePrice,
    bool? byMain,
    int? sort,
    int? setNumber,
    dynamic description,
    String? paidBy,
    String? accountant,
    String? fileType,
    String? attachment,
    String? idempotentToken,
    String? customerName,
    dynamic customerCode,
    double? customerCurrentLoan,
    int? customerId,
    String? invoiceNumber,
    dynamic safeboxName,
    int? safeboxId,
    String? payType,
    bool? isTransferredToCash,
    String? kuPriceText,
    String? arPriceText,
    String? enPriceText,
    dynamic deadLine,
  }) =>
      PaymentModel(
        id: id ?? this.id,
        note: note ?? this.note,
        date: date ?? this.date,
        price: price ?? this.price,
        forgivePrice: forgivePrice ?? this.forgivePrice,
        scPrice: scPrice ?? this.scPrice,
        scForgivePrice: scForgivePrice ?? this.scForgivePrice,
        byMain: byMain ?? this.byMain,
        sort: sort ?? this.sort,
        setNumber: setNumber ?? this.setNumber,
        description: description ?? this.description,
        paidBy: paidBy ?? this.paidBy,
        accountant: accountant ?? this.accountant,
        fileType: fileType ?? this.fileType,
        attachment: attachment ?? this.attachment,
        idempotentToken: idempotentToken ?? this.idempotentToken,
        customerName: customerName ?? this.customerName,
        customerCurrentLoan: customerCurrentLoan ?? this.customerCurrentLoan,
        customerId: customerId ?? this.customerId,
        invoiceNumber: invoiceNumber ?? this.invoiceNumber,
        safeboxName: safeboxName ?? this.safeboxName,
        safeboxId: safeboxId ?? this.safeboxId,
        payType: payType ?? this.payType,
        isTransferredToCash: isTransferredToCash ?? this.isTransferredToCash,
        kuPriceText: kuPriceText ?? this.kuPriceText,
        arPriceText: arPriceText ?? this.arPriceText,
        enPriceText: enPriceText ?? this.enPriceText,
      );

  factory PaymentModel.fromMap(Map<String, dynamic> json) => PaymentModel(
        id: json["id"],
        note: json["note"],
        date: DateTime.parse(json["date"]),
        price: checkDouble(json["price"]),
        forgivePrice: checkDouble(json["forgivePrice"]),
        scPrice: checkDouble(json["scPrice"]),
        scForgivePrice: checkDouble(json["scForgivePrice"]),
        byMain: json["byMain"],
        sort: json["sort"],
        setNumber: json["setNumber"],
        description: json["description"],
        paidBy: json["paidBy"],
        accountant: json["accountant"],
        fileType: json["fileType"],
        attachment: json["attachment"],
        idempotentToken: json["idempotentToken"],
        customerName: json["customerName"],
        customerCurrentLoan: checkDouble(json["customerCurrentLoan"]),
        customerId: json["customerId"],
        invoiceNumber: json["invoiceNumber"],
        safeboxName: json["safeboxName"],
        safeboxId: json["safeboxId"],
        payType: json["payType"],
        isTransferredToCash: json["isTransferredToCash"],
        kuPriceText: json["kuPriceText"],
        arPriceText: json["arPriceText"],
        enPriceText: json["enPriceText"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "note": note,
        "date": date.toIso8601String(),
        "price": price,
        "forgivePrice": forgivePrice,
        "scPrice": scPrice,
        "scForgivePrice": scForgivePrice,
        "byMain": byMain,
        "sort": sort,
        "setNumber": setNumber,
        "description": description,
        "paidBy": paidBy,
        "accountant": accountant,
        "fileType": fileType,
        "attachment": attachment,
        "idempotentToken": idempotentToken,
        "customerName": customerName,
        "customerCurrentLoan": customerCurrentLoan,
        "customerId": customerId,
        "invoiceNumber": invoiceNumber,
        "safeboxName": safeboxName,
        "safeboxId": safeboxId,
        "payType": payType,
        "isTransferredToCash": isTransferredToCash,
        "kuPriceText": kuPriceText,
        "arPriceText": arPriceText,
        "enPriceText": enPriceText,
      };

  @override
  List<Object?> get props => [
        id,
        note,
        date,
        price,
        forgivePrice,
        scPrice,
        scForgivePrice,
        byMain,
        sort,
        setNumber,
        description,
        paidBy,
        accountant,
        fileType,
        attachment,
        idempotentToken,
        customerName,
        customerCurrentLoan,
        customerId,
        invoiceNumber,
        safeboxName,
        safeboxId,
        payType,
        isTransferredToCash,
        kuPriceText,
        arPriceText,
        enPriceText,
      ];
}
