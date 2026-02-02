import 'dart:convert';

import 'package:app/core/shared/imports.dart';

class CustomerInfoModel extends Equatable {
  final String name;
  final String? code;
  final String? address;
  final String? email;
  final String? phone;
  final double currentLoan;
  final double doubleEntryLoan;
  const CustomerInfoModel({
    required this.name,
    this.code,
    this.address,
    this.email,
    this.phone,
    required this.currentLoan,
    required this.doubleEntryLoan,
  });

  CustomerInfoModel copyWith({
    String? name,
    String? code,
    String? address,
    String? email,
    String? phone,
    double? currentLoan,
    double? doubleEntryLoan,
  }) {
    return CustomerInfoModel(
      name: name ?? this.name,
      code: code ?? this.code,
      address: address ?? this.address,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      currentLoan: currentLoan ?? this.currentLoan,
      doubleEntryLoan: doubleEntryLoan ?? this.doubleEntryLoan,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code': code,
      'address': address,
      'email': email,
      'phone': phone,
      'currentLoan': currentLoan,
      'doubleEntryLoan': doubleEntryLoan,
    };
  }

  factory CustomerInfoModel.fromMap(Map<String, dynamic> map) {
    return CustomerInfoModel(
      name: map['name'] ?? '',
      code: map['code'],
      address: map['address'],
      email: map['email'],
      phone: map['phone'],
      currentLoan: checkDouble(map['currentLoan']),
      doubleEntryLoan: checkDouble(map['doubleEntryLoan']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerInfoModel.fromJson(String source) =>
      CustomerInfoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CustomerInfoModel(name: $name, code: $code, address: $address, email: $email, phone: $phone, currentLoan: $currentLoan, doubleEntryLoan: $doubleEntryLoan)';
  }

  @override
  List<Object?> get props {
    return [
      name,
      code,
      address,
      email,
      phone,
      currentLoan,
      doubleEntryLoan,
    ];
  }
}
