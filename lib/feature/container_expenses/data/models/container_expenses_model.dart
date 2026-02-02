import 'package:app/core/shared/imports.dart';
import 'package:app/feature/containers/data/models/containers_model.dart';

class ContainerExpenseModel extends Equatable {
  final int id;
  final String? name;
  final String? definer;
  final String? invoiceNumber;
  final String? idempotentToken;
  final String? description;
  final DateTime date;
  final double price;
  final double scPrice;
  final bool byMain;
  final int setNumber;
  final int sort;
  final String? bgColor;
  final String? attachment;
  final String? receiver;
  final String? accountant;
  final int containerId;
  final ContainerModel container;
  final String? safeboxName;
  final int safeboxId;
  final String? note;

  const ContainerExpenseModel({
    required this.id,
    required this.name,
    required this.definer,
    required this.invoiceNumber,
    required this.idempotentToken,
    required this.description,
    required this.date,
    required this.price,
    required this.scPrice,
    required this.byMain,
    required this.setNumber,
    required this.sort,
    required this.bgColor,
    required this.attachment,
    required this.receiver,
    required this.accountant,
    required this.containerId,
    required this.container,
    required this.safeboxName,
    required this.safeboxId,
    required this.note,
  });

  ContainerExpenseModel copyWith({
    int? id,
    String? name,
    String? definer,
    String? invoiceNumber,
    String? idempotentToken,
    String? description,
    DateTime? date,
    double? price,
    double? scPrice,
    bool? byMain,
    int? setNumber,
    int? sort,
    String? bgColor,
    String? attachment,
    String? receiver,
    String? accountant,
    int? containerId,
    ContainerModel? container,
    String? safeboxName,
    int? safeboxId,
    String? note,
  }) =>
      ContainerExpenseModel(
        id: id ?? this.id,
        name: name ?? this.name,
        definer: definer ?? this.definer,
        invoiceNumber: invoiceNumber ?? this.invoiceNumber,
        idempotentToken: idempotentToken ?? this.idempotentToken,
        description: description ?? this.description,
        date: date ?? this.date,
        price: price ?? this.price,
        scPrice: scPrice ?? this.scPrice,
        byMain: byMain ?? this.byMain,
        setNumber: setNumber ?? this.setNumber,
        sort: sort ?? this.sort,
        bgColor: bgColor ?? this.bgColor,
        attachment: attachment ?? this.attachment,
        receiver: receiver ?? this.receiver,
        accountant: accountant ?? this.accountant,
        containerId: containerId ?? this.containerId,
        container: container ?? this.container,
        safeboxName: safeboxName ?? this.safeboxName,
        safeboxId: safeboxId ?? this.safeboxId,
        note: note ?? this.note,
      );

  factory ContainerExpenseModel.fromMap(Map<String, dynamic> json) =>
      ContainerExpenseModel(
        id: json["id"],
        name: json["name"],
        definer: json["definer"],
        invoiceNumber: json["invoiceNumber"],
        idempotentToken: json["idempotentToken"],
        description: json["description"],
        date: DateTime.parse(json["date"]),
        price: checkDouble(json["price"]),
        scPrice: checkDouble(json["scPrice"]),
        byMain: json["byMain"],
        setNumber: json["setNumber"],
        sort: json["sort"],
        bgColor: json["bgColor"],
        attachment: json["attachment"],
        receiver: json["receiver"],
        accountant: json["accountant"],
        containerId: json["containerId"],
        container: ContainerModel.fromMap(json["container"]),
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
        "price": price,
        "scPrice": scPrice,
        "byMain": byMain,
        "setNumber": setNumber,
        "sort": sort,
        "bgColor": bgColor,
        "attachment": attachment,
        "receiver": receiver,
        "accountant": accountant,
        "containerId": containerId,
        "container": container.toMap(),
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
        price,
        scPrice,
        byMain,
        setNumber,
        sort,
        bgColor,
        attachment,
        receiver,
        accountant,
        containerId,
        container,
        safeboxName,
        safeboxId,
        note
      ];
}
