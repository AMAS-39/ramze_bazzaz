import 'dart:convert';

import 'package:equatable/equatable.dart';

class UnitModel extends Equatable {
  const UnitModel();

  Map<String, dynamic> toMap() {
    return {};
  }

  factory UnitModel.fromMap(dynamic map) {
    return const UnitModel();
  }

  String toJson() => json.encode(toMap());

  factory UnitModel.fromJson(String source) =>
      UnitModel.fromMap(json.decode(source));

  @override
  String toString() => 'UnitModel( )';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UnitModel;
  }

  @override
  int get hashCode => 0;

  @override
  List<Object?> get props => [];
}
