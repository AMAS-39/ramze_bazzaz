import 'dart:convert';

import 'package:app/core/shared/imports.dart';
import 'package:equatable/equatable.dart';

class CustomerDoubleEntrysFilterModel extends Equatable {
  final int setNumber;
  const CustomerDoubleEntrysFilterModel({
    required this.setNumber,
  });

  CustomerDoubleEntrysFilterModel copyWith({
    int? setNumber,
  }) {
    return CustomerDoubleEntrysFilterModel(
      setNumber: setNumber ?? this.setNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'setNumber': setNumber,
    };
  }

  factory CustomerDoubleEntrysFilterModel.fromMap(Map<String, dynamic> map) {
    return CustomerDoubleEntrysFilterModel(
      setNumber: map['setNumber']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerDoubleEntrysFilterModel.fromJson(String source) =>
      CustomerDoubleEntrysFilterModel.fromMap(json.decode(source));

  @override
  String toString() => 'CustomerDoubleEntrysFilterModel(setNumber: $setNumber)';

  @override
  List<Object> get props => [setNumber];
}
