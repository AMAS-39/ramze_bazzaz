import 'dart:convert';

import 'package:app/core/shared/imports.dart';
import 'package:equatable/equatable.dart';

class ContainerExpensesFilterModel extends Equatable {
  final int setNumber;
  const ContainerExpensesFilterModel({
    required this.setNumber,
  });

  ContainerExpensesFilterModel copyWith({
    int? setNumber,
  }) {
    return ContainerExpensesFilterModel(
      setNumber: setNumber ?? this.setNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'setNumber': setNumber,
    };
  }

  factory ContainerExpensesFilterModel.fromMap(Map<String, dynamic> map) {
    return ContainerExpensesFilterModel(
      setNumber: map['setNumber']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContainerExpensesFilterModel.fromJson(String source) =>
      ContainerExpensesFilterModel.fromMap(json.decode(source));

  @override
  String toString() => 'ContainerExpensesFilterModel(setNumber: $setNumber)';

  @override
  List<Object> get props => [setNumber];
}
