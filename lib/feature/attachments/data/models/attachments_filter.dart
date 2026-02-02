import 'dart:convert';

import 'package:app/core/shared/imports.dart';
import 'package:equatable/equatable.dart';

class AttachmentsFilterModel extends Equatable {
  final int setNumber;
  const AttachmentsFilterModel({
    required this.setNumber,
  });

  AttachmentsFilterModel copyWith({
    int? setNumber,
  }) {
    return AttachmentsFilterModel(
      setNumber: setNumber ?? this.setNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'setNumber': setNumber,
    };
  }

  factory AttachmentsFilterModel.fromMap(Map<String, dynamic> map) {
    return AttachmentsFilterModel(
      setNumber: map['setNumber']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AttachmentsFilterModel.fromJson(String source) =>
      AttachmentsFilterModel.fromMap(json.decode(source));

  @override
  String toString() => 'AttachmentsFilterModel(setNumber: $setNumber)';

  @override
  List<Object> get props => [setNumber];
}
