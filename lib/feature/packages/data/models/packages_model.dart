import 'dart:convert';

import 'package:app/core/shared/imports.dart';
import 'package:app/feature/containers/data/models/containers_model.dart';

class PackageModel extends Equatable {
  final int id;
  final String? invoiceNumber;
  final String? description;
  final DateTime date;
  final PackageStatus packageStatus;
  final double height;
  final double width;
  final double length;
  final double weight;
  final double qty;
  final double cbm;
  final double totalPrice;
  final double unitPrice;
  final String? attachment;
  final DateTime? deadline;
  final int setNumber;
  final int sort;
  final String? bgColor;
  final String? itemName;
  final int itemId;
  final ContainerModel container;
  final int containerId;
  final String customerName;
  final int customerId;
  const PackageModel({
    required this.id,
    this.invoiceNumber,
    required this.description,
    required this.date,
    required this.packageStatus,
    required this.height,
    required this.width,
    required this.length,
    required this.weight,
    required this.qty,
    required this.cbm,
    required this.totalPrice,
    required this.unitPrice,
    this.attachment,
    this.deadline,
    required this.setNumber,
    required this.sort,
    this.bgColor,
    this.itemName,
    required this.itemId,
    required this.container,
    required this.containerId,
    required this.customerName,
    required this.customerId,
  });

  PackageModel copyWith({
    int? id,
    String? invoiceNumber,
    String? description,
    DateTime? date,
    PackageStatus? packageStatus,
    double? height,
    double? width,
    double? length,
    double? weight,
    double? qty,
    double? cbm,
    double? totalPrice,
    double? unitPrice,
    String? attachment,
    DateTime? deadline,
    int? setNumber,
    int? sort,
    String? bgColor,
    String? itemName,
    int? itemId,
    ContainerModel? container,
    int? containerId,
    String? customerName,
    int? customerId,
  }) {
    return PackageModel(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      description: description ?? this.description,
      date: date ?? this.date,
      packageStatus: packageStatus ?? this.packageStatus,
      height: height ?? this.height,
      width: width ?? this.width,
      length: length ?? this.length,
      weight: weight ?? this.weight,
      qty: qty ?? this.qty,
      cbm: cbm ?? this.cbm,
      totalPrice: totalPrice ?? this.totalPrice,
      unitPrice: unitPrice ?? this.unitPrice,
      attachment: attachment ?? this.attachment,
      deadline: deadline ?? this.deadline,
      setNumber: setNumber ?? this.setNumber,
      sort: sort ?? this.sort,
      bgColor: bgColor ?? this.bgColor,
      itemName: itemName ?? this.itemName,
      itemId: itemId ?? this.itemId,
      container: container ?? this.container,
      containerId: containerId ?? this.containerId,
      customerName: customerName ?? this.customerName,
      customerId: customerId ?? this.customerId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'invoiceNumber': invoiceNumber,
      'description': description,
      'date': date.toIso8601String(),
      'packageStatus': packageStatus.name,
      'height': height,
      'width': width,
      'length': length,
      'weight': weight,
      'qty': qty,
      'cbm': cbm,
      'totalPrice': totalPrice,
      'unitPrice': unitPrice,
      'attachment': attachment,
      'deadline': deadline?.toIso8601String(),
      'setNumber': setNumber,
      'sort': sort,
      'bgColor': bgColor,
      'itemName': itemName,
      'itemId': itemId,
      'container': container.toMap(),
      'containerId': containerId,
      'customerName': customerName,
      'customerId': customerId,
    };
  }

  factory PackageModel.fromMap(Map<String, dynamic> map) {
    final totalPrice = checkDouble(map['totalPrice']);
    final qty = checkDouble(map['qty']);
    final unitPriceRaw = map['unitprice'] ?? map['unit_price'] ?? map['unitPrice'] ?? map['price'];
    final unitPrice = unitPriceRaw != null
        ? checkDouble(unitPriceRaw)
        : (qty > 0 ? totalPrice / qty : 0.0);
    return PackageModel(
      id: checkInt(map['id']),
      invoiceNumber: map['invoiceNumber'],
      description: map['description'] ?? '',
      date: DateTime.parse(map['date']),
      packageStatus: PackageStatus.fromMap(map['packageStatus']),
      height: checkDouble(map['height']),
      width: checkDouble(map['width']),
      length: checkDouble(map['length']),
      weight: checkDouble(map['weight']),
      qty: qty,
      cbm: checkDouble(map['cbm']),
      totalPrice: totalPrice,
      unitPrice: unitPrice,
      attachment: map['attachment'],
      deadline: DateTime.tryParse(map['deadline'] ?? ""),
      setNumber: checkInt(map['setNumber']),
      sort: checkInt(map['sort']),
      bgColor: map['bgColor'],
      itemName: map['itemName'],
      itemId: checkInt(map['itemId']),
      container: ContainerModel.fromMap(map['container']),
      containerId: checkInt(map['containerId']),
      customerName: map['customerName'] ?? '',
      customerId: checkInt(map['customerId']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageModel.fromJson(String source) =>
      PackageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PackageModel(id: $id, invoiceNumber: $invoiceNumber, description: $description, date: $date, packageStatus: $packageStatus, height: $height, width: $width, length: $length, weight: $weight, qty: $qty, cbm: $cbm, totalPrice: $totalPrice, unitPrice: $unitPrice, attachment: $attachment, deadline: $deadline, setNumber: $setNumber, sort: $sort, bgColor: $bgColor, itemName: $itemName, itemId: $itemId, container: $container, containerId: $containerId, customerName: $customerName, customerId: $customerId)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      invoiceNumber,
      description,
      date,
      packageStatus,
      height,
      width,
      length,
      weight,
      qty,
      cbm,
      totalPrice,
      unitPrice,
      attachment,
      deadline,
      setNumber,
      sort,
      bgColor,
      itemName,
      itemId,
      container,
      containerId,
      customerName,
      customerId,
    ];
  }
}
