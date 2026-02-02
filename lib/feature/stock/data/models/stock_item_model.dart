import 'dart:convert';

import 'package:app/core/shared/imports.dart';
import 'package:equatable/equatable.dart';

class StockItemModel extends Equatable {
  final int id;
  final String? title;
  final String? imageUrl;
  final double totalPrice;
  final double price;
  final double extraPrice;
  final double quantity;
  final double cbm;
  final double weight;
  final String? status;
  final String? description;
  final DateTime? createdDate;

  const StockItemModel({
    required this.id,
    this.title,
    this.imageUrl,
    this.totalPrice = 0,
    this.price = 0,
    this.extraPrice = 0,
    this.quantity = 0,
    this.cbm = 0,
    this.weight = 0,
    this.status,
    this.description,
    this.createdDate,
  });

  String get formattedPrice => totalPrice.formatUSD;
  String get formattedQuantity => quantity.toStringAsFixed(quantity == quantity.truncate() ? 0 : 1);
  String get formattedCbm => cbm.toString();
  String get formattedWeight => weight.toString();
  String get formattedCreatedDate => createdDate?.onlyDate ?? "";
  String get formattedStatus => status ?? "";

  static dynamic _get(Map<String, dynamic> map, List<String> keys) {
    for (final k in keys) {
      if (map.containsKey(k)) return map[k];
      final lower = k.toLowerCase();
      for (final entry in map.entries) {
        if (entry.key.toString().toLowerCase() == lower) return entry.value;
      }
    }
    return null;
  }

  factory StockItemModel.fromMap(Map<String, dynamic> map) {
    final id = checkInt(_get(map, ['id', 'Id']));
    final title = _get(map, ['title', 'packagename', 'description', 'Title'])?.toString();
    final imageUrl = _get(map, ['imageurl', 'image', 'imageUrl'])?.toString();
    final totalPrice = checkDouble(_get(map, ['totalprice', 'totalPrice', 'price', 'Price']));
    final price = checkDouble(_get(map, ['price', 'unitprice', 'unit_price', 'Price']));
    final extraPrice = checkDouble(_get(map, ['extraprice', 'extraPrice']));
    final quantity = checkDouble(_get(map, ['qty', 'quantity', 'Quantity']));
    final cbm = checkDouble(_get(map, ['cbm', 'Cbm']));
    final weight = checkDouble(_get(map, ['weight', 'Weight']));
    final status = _get(map, ['packagestatus', 'containerstatus', 'status', 'packageStatus'])?.toString();
    final description = _get(map, ['description', 'note', 'Description'])?.toString();
    final dateRaw = _get(map, ['date', 'createddate', 'createdDate']);
    final createdDate = dateRaw != null
        ? (dateRaw is DateTime ? dateRaw : DateTime.tryParse(dateRaw.toString()))
        : null;

    return StockItemModel(
      id: id,
      title: title,
      imageUrl: imageUrl,
      totalPrice: totalPrice,
      price: price,
      extraPrice: extraPrice,
      quantity: quantity,
      cbm: cbm,
      weight: weight,
      status: status,
      description: description,
      createdDate: createdDate,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'imageUrl': imageUrl,
        'totalPrice': totalPrice,
        'price': price,
        'extraPrice': extraPrice,
        'quantity': quantity,
        'cbm': cbm,
        'weight': weight,
        'status': status,
        'description': description,
        'createdDate': createdDate?.toIso8601String(),
      };

  String toJson() => json.encode(toMap());

  factory StockItemModel.fromJson(String source) =>
      StockItemModel.fromMap(Map<String, dynamic>.from(json.decode(source)));

  @override
  List<Object?> get props => [id, title, imageUrl, totalPrice, price, quantity, cbm, weight, status, description, createdDate];
}
