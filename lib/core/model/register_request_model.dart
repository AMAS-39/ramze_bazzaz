import 'dart:convert';

class RegisterModel {
  final String name;
  final String lastName;
  final String phone;
  RegisterModel({
    required this.name,
    required this.lastName,
    required this.phone,
  });

  RegisterModel copyWith({
    String? name,
    String? lastName,
    String? phone,
  }) {
    return RegisterModel(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'last_name': lastName,
      'phone': phone,
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      name: map['name'] ?? '',
      lastName: map['last_name'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterModel.fromJson(String source) =>
      RegisterModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RegisterModel(name: $name, last_name: $lastName, phone: $phone)';
  }
}
