 
import 'dart:convert';

import 'package:app/core/shared/imports.dart';
import 'package:equatable/equatable.dart';

class PaymentsFilterModel extends Equatable {
  final int setNumber;
  const PaymentsFilterModel({
    required this.setNumber,
  });

  PaymentsFilterModel copyWith({
    int? setNumber,
  }) {
    return PaymentsFilterModel(
      setNumber: setNumber ?? this.setNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'setNumber': setNumber,
    };
  }

  factory PaymentsFilterModel.fromMap(Map<String, dynamic> map) {
    return PaymentsFilterModel(
      setNumber: map['setNumber']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentsFilterModel.fromJson(String source) =>
      PaymentsFilterModel.fromMap(json.decode(source));

  @override
  String toString() => 'PaymentsFilterModel(setNumber: $setNumber)';

  @override
  List<Object> get props => [setNumber];
}
