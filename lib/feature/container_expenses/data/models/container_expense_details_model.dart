import 'package:equatable/equatable.dart';

class ContainerExpenseDetailsModel extends Equatable {
  final int id;
  final String? name;
  final String? definer;
  final String? invoiceNumber;
  final String? idempotentToken;
  final String? description;
  final DateTime date;
  final int cost;
  final int scCost;
  final int price;
  final int scPrice;
  final int exchangeRate;
  final bool byMain;
  final bool isCash;
  final int setNumber;
  final int sort;
  final String? bgColor;
  final String? attachment;
  final String? receiver;
  final String? accountant;
  final int containerId;
  final String? containerNumber;
  final String? transporterName;
  final int transporterId;
  final String? customerName;
  final int customerId;
  final String? safeboxName;
  final int safeboxId;
  final String? note;

  const ContainerExpenseDetailsModel({
    required this.id,
    required this.name,
    required this.definer,
    required this.invoiceNumber,
    required this.idempotentToken,
    required this.description,
    required this.date,
    required this.cost,
    required this.scCost,
    required this.price,
    required this.scPrice,
    required this.exchangeRate,
    required this.byMain,
    required this.isCash,
    required this.setNumber,
    required this.sort,
    required this.bgColor,
    required this.attachment,
    required this.receiver,
    required this.accountant,
    required this.containerId,
    required this.containerNumber,
    required this.transporterName,
    required this.transporterId,
    required this.customerName,
    required this.customerId,
    required this.safeboxName,
    required this.safeboxId,
    required this.note,
  });

  ContainerExpenseDetailsModel copyWith({
    int? id,
    String? name,
    String? definer,
    String? invoiceNumber,
    String? idempotentToken,
    String? description,
    DateTime? date,
    int? cost,
    int? scCost,
    int? price,
    int? scPrice,
    int? exchangeRate,
    bool? byMain,
    bool? isCash,
    int? setNumber,
    int? sort,
    String? bgColor,
    String? attachment,
    String? receiver,
    String? accountant,
    int? containerId,
    String? containerNumber,
    String? transporterName,
    int? transporterId,
    String? customerName,
    int? customerId,
    String? safeboxName,
    int? safeboxId,
    String? note,
  }) =>
      ContainerExpenseDetailsModel(
        id: id ?? this.id,
        name: name ?? this.name,
        definer: definer ?? this.definer,
        invoiceNumber: invoiceNumber ?? this.invoiceNumber,
        idempotentToken: idempotentToken ?? this.idempotentToken,
        description: description ?? this.description,
        date: date ?? this.date,
        cost: cost ?? this.cost,
        scCost: scCost ?? this.scCost,
        price: price ?? this.price,
        scPrice: scPrice ?? this.scPrice,
        exchangeRate: exchangeRate ?? this.exchangeRate,
        byMain: byMain ?? this.byMain,
        isCash: isCash ?? this.isCash,
        setNumber: setNumber ?? this.setNumber,
        sort: sort ?? this.sort,
        bgColor: bgColor ?? this.bgColor,
        attachment: attachment ?? this.attachment,
        receiver: receiver ?? this.receiver,
        accountant: accountant ?? this.accountant,
        containerId: containerId ?? this.containerId,
        containerNumber: containerNumber ?? this.containerNumber,
        transporterName: transporterName ?? this.transporterName,
        transporterId: transporterId ?? this.transporterId,
        customerName: customerName ?? this.customerName,
        customerId: customerId ?? this.customerId,
        safeboxName: safeboxName ?? this.safeboxName,
        safeboxId: safeboxId ?? this.safeboxId,
        note: note ?? this.note,
      );

  factory ContainerExpenseDetailsModel.fromMap(Map<String, dynamic> json) =>
      ContainerExpenseDetailsModel(
        id: json["id"],
        name: json["name"],
        definer: json["definer"],
        invoiceNumber: json["invoiceNumber"],
        idempotentToken: json["idempotentToken"],
        description: json["description"],
        date: DateTime.parse(json["date"]),
        cost: json["cost"],
        scCost: json["scCost"],
        price: json["price"],
        scPrice: json["scPrice"],
        exchangeRate: json["exchangeRate"],
        byMain: json["byMain"],
        isCash: json["isCash"],
        setNumber: json["setNumber"],
        sort: json["sort"],
        bgColor: json["bgColor"],
        attachment: json["attachment"],
        receiver: json["receiver"],
        accountant: json["accountant"],
        containerId: json["containerId"],
        containerNumber: json["containerNumber"],
        transporterName: json["transporterName"],
        transporterId: json["transporterId"],
        customerName: json["customerName"],
        customerId: json["customerId"],
        safeboxName: json["safeboxName"],
        safeboxId: json["safeboxId"],
        note: json["note"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "definer": definer,
        "invoiceNumber": invoiceNumber,
        "idempotentToken": idempotentToken,
        "description": description,
        "date": date.toIso8601String(),
        "cost": cost,
        "scCost": scCost,
        "price": price,
        "scPrice": scPrice,
        "exchangeRate": exchangeRate,
        "byMain": byMain,
        "isCash": isCash,
        "setNumber": setNumber,
        "sort": sort,
        "bgColor": bgColor,
        "attachment": attachment,
        "receiver": receiver,
        "accountant": accountant,
        "containerId": containerId,
        "containerNumber": containerNumber,
        "transporterName": transporterName,
        "transporterId": transporterId,
        "customerName": customerName,
        "customerId": customerId,
        "safeboxName": safeboxName,
        "safeboxId": safeboxId,
        "note": note,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        definer,
        invoiceNumber,
        idempotentToken,
        description,
        date,
        cost,
        scCost,
        price,
        scPrice,
        exchangeRate,
        byMain,
        isCash,
        setNumber,
        sort,
        bgColor,
        attachment,
        receiver,
        accountant,
        containerId,
        containerNumber,
        transporterName,
        transporterId,
        customerName,
        customerId,
        safeboxName,
        safeboxId,
        note
      ];
}
