import 'dart:convert';

import 'package:app/core/shared/imports.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class PackagesFilterModel extends Equatable {
  final int setNumber;
  const PackagesFilterModel({
    required this.setNumber,
  });

  PackagesFilterModel copyWith({
    int? setNumber,
  }) {
    return PackagesFilterModel(
      setNumber: setNumber ?? this.setNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'setNumber': setNumber,
    };
  }

  factory PackagesFilterModel.fromMap(Map<String, dynamic> map) {
    return PackagesFilterModel(
      setNumber: map['setNumber']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PackagesFilterModel.fromJson(String source) =>
      PackagesFilterModel.fromMap(json.decode(source));

  @override
  String toString() => 'PackagesFilterModel(setNumber: $setNumber)';

  @override
  List<Object> get props => [setNumber];
}

enum PackageStatusFilter {
  all,
  newPackage,
  shipped,
  arrived,
}

extension PackageStatusFilterExt on PackageStatusFilter {
  String label(BuildContext context) {
    switch (this) {
      case PackageStatusFilter.all:
        return Trans.all.trans(context: context);
      case PackageStatusFilter.newPackage:
        return Trans.newW.trans(context: context);
      case PackageStatusFilter.shipped:
        return Trans.inShipping.trans(context: context);
      case PackageStatusFilter.arrived:
        return Trans.arrived.trans(context: context);
    }
  }

  bool matches({
    required PackageStatus packageStatus,
    required ContainerStatus containerStatus,
    DateTime? arrivalDate,
  }) {
    final bool isArrivalDatePassed =
        arrivalDate != null && arrivalDate.isBefore(DateTime.now());
    switch (this) {
      case PackageStatusFilter.all:
        return true;
      case PackageStatusFilter.newPackage:
        if (isArrivalDatePassed && packageStatus == PackageStatus.New) {
          return false;
        }
        return packageStatus == PackageStatus.New ||
            containerStatus == ContainerStatus.New;
      case PackageStatusFilter.shipped:
        return packageStatus == PackageStatus.InShipping ||
            containerStatus == ContainerStatus.InShipping;
      case PackageStatusFilter.arrived:
        if (isArrivalDatePassed && packageStatus == PackageStatus.New) {
          return true;
        }
        return containerStatus == ContainerStatus.Arrived ||
            packageStatus == PackageStatus.InDestinationStock ||
            packageStatus == PackageStatus.Delivered;
    }
  }
}
