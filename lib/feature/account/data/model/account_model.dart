import 'dart:convert';

import 'package:app/core/shared/imports.dart';

class AccountModel extends Equatable {
  final String id;
  final String userName;
  final bool userStatus;
  final String? email;
  final String token;
  final String refreshToken;
  final String code;
  final String secondCode;
  final String userType;
  final DateTime? expiration;
  final String fullName;
  final String? image;
  final int projectId;
  final bool byMain;
  final int safeboxId;
  final String firstName;
  final String? middleName;
  final String? lastName;
  final String? phone;
  final double main2SecondRatio;
  final double main2SecondRatio2;
  const AccountModel({
    required this.id,
    required this.userName,
    required this.userStatus,
    this.email,
    required this.token,
    required this.refreshToken,
    required this.code,
    required this.secondCode,
    required this.userType,
    this.expiration,
    required this.fullName,
    this.image,
    required this.projectId,
    required this.byMain,
    required this.safeboxId,
    required this.firstName,
    this.middleName,
    this.lastName,
    this.phone,
    required this.main2SecondRatio,
    required this.main2SecondRatio2,
  });

  AccountModel copyWith({
    String? id,
    String? userName,
    bool? userStatus,
    String? email,
    String? token,
    String? refreshToken,
    String? code,
    String? secondCode,
    String? userType,
    DateTime? expiration,
    String? fullName,
    String? image,
    int? projectId,
    bool? byMain,
    int? safeboxId,
    String? firstName,
    String? middleName,
    String? lastName,
    String? phone,
    double? main2SecondRatio,
    double? main2SecondRatio2,
  }) {
    return AccountModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      userStatus: userStatus ?? this.userStatus,
      email: email ?? this.email,
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      code: code ?? this.code,
      secondCode: secondCode ?? this.secondCode,
      userType: userType ?? this.userType,
      expiration: expiration ?? this.expiration,
      fullName: fullName ?? this.fullName,
      image: image ?? this.image,
      projectId: projectId ?? this.projectId,
      byMain: byMain ?? this.byMain,
      safeboxId: safeboxId ?? this.safeboxId,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      main2SecondRatio: main2SecondRatio ?? this.main2SecondRatio,
      main2SecondRatio2: main2SecondRatio2 ?? this.main2SecondRatio2,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'userStatus': userStatus,
      'email': email,
      'token': token,
      'refreshToken': refreshToken,
      'code': code,
      'secondCode': secondCode,
      'userType': userType,
      'expiration': expiration?.toIso8601String(),
      'fullName': fullName,
      'image': image,
      'projectId': projectId,
      'byMain': byMain,
      'safeboxId': safeboxId,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'phone': phone,
      'main2SecondRatio': main2SecondRatio,
      'main2SecondRatio2': main2SecondRatio2,
    };
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      id: map['id'] ?? '',
      userName: map['userName'] ?? '',
      userStatus: checkBool(map['userStatus']),
      email: map['email'],
      token: map['token'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
      code: map['code'] ?? '',
      secondCode: map['secondCode'] ?? '',
      userType: map['userType'] ?? '',
      expiration: DateTime.tryParse(map['expiration'] ?? ""),
      fullName: map['fullName'] ?? '',
      image: map['image'],
      projectId: checkInt(map['projectId']),
      byMain: checkBool(map['byMain']),
      safeboxId: checkInt(map['safeboxId']),
      firstName: map['firstName'] ?? '',
      middleName: map['middleName'],
      lastName: map['lastName'],
      phone: map['phone'],
      main2SecondRatio: checkDouble(map['main2SecondRatio']),
      main2SecondRatio2: checkDouble(map['main2SecondRatio2']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountModel.fromJson(String source) =>
      AccountModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AccountModel(id: $id, userName: $userName, userStatus: $userStatus, email: $email, token: $token, refreshToken: $refreshToken, code: $code, secondCode: $secondCode, userType: $userType, expiration: $expiration, fullName: $fullName, image: $image, projectId: $projectId, byMain: $byMain, safeboxId: $safeboxId, firstName: $firstName, middleName: $middleName, lastName: $lastName, phone: $phone, main2SecondRatio: $main2SecondRatio, main2SecondRatio2: $main2SecondRatio2)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      userName,
      userStatus,
      email,
      token,
      refreshToken,
      code,
      secondCode,
      userType,
      expiration,
      fullName,
      image,
      projectId,
      byMain,
      safeboxId,
      firstName,
      middleName,
      lastName,
      phone,
      main2SecondRatio,
      main2SecondRatio2,
    ];
  }
}
