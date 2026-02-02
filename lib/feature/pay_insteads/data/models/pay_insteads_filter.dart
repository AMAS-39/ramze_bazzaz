import 'dart:convert';

import 'package:app/core/shared/imports.dart';
import 'package:equatable/equatable.dart';

class PayInsteadsFilterModel extends Equatable {
  final bool isLost;
  final int setNumber;
  const PayInsteadsFilterModel({
    required this.isLost,
    required this.setNumber,
  });

  PayInsteadsFilterModel copyWith({
    bool? isLost,
    int? setNumber,
  }) {
    return PayInsteadsFilterModel(
      isLost: isLost ?? this.isLost,
      setNumber: setNumber ?? this.setNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isLost': isLost,
      'setNumber': setNumber,
    };
  }

  factory PayInsteadsFilterModel.fromMap(Map<String, dynamic> map) {
    return PayInsteadsFilterModel(
      isLost: map['isLost'] ?? false,
      setNumber: map['setNumber']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PayInsteadsFilterModel.fromJson(String source) =>
      PayInsteadsFilterModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'PayInsteadsFilterModel(isLost: $isLost, setNumber: $setNumber)';

  @override
  List<Object> get props => [isLost, setNumber];
}
