import 'dart:convert';

import 'package:app/core/shared/imports.dart';

class SettingsModel extends Equatable {
  const SettingsModel(
      {required this.success, required this.data, required this.message});

  String toJson() => json.encode(toMap());

  factory SettingsModel.fromJson(String source) =>
      SettingsModel.fromMap(json.decode(source));
  final bool success;
  final SettingDataModel data;
  final String message;

  factory SettingsModel.fromMap(Map<String, dynamic> json) => SettingsModel(
      success: json["success"],
      data: SettingDataModel.fromMap(json["data"]),
      message: json["message"]);

  Map<String, dynamic> toMap() =>
      {"success": success, "data": data.toMap(), "message": message};

  @override
  List<Object?> get props => [success, data, message];

  @override
  String toString() =>
      'SettingsModel(success: $success, data: $data, message: $message)';
}

class SettingDataModel extends Equatable {
  const SettingDataModel({
    required this.appName,
    required this.defaultTax,
    required this.defaultCurrency,
    required this.mainColor,
    required this.mainDarkColor,
    required this.secondColor,
    required this.secondDarkColor,
    required this.accentColor,
    required this.accentDarkColor,
    required this.scaffoldDarkColor,
    required this.scaffoldColor,
  });

  final String appName;
  final double defaultTax;
  final String defaultCurrency;
  final String mainColor;
  final String mainDarkColor;
  final String secondColor;
  final String secondDarkColor;
  final String accentColor;
  final String accentDarkColor;
  final String scaffoldDarkColor;
  final String scaffoldColor;

  factory SettingDataModel.fromMap(Map<String, dynamic> json) =>
      SettingDataModel(
        appName: json["app_name"],
        defaultTax: checkDouble(json["default_tax"]),
        defaultCurrency: json["default_currency"],
        mainColor: json["main_color"],
        mainDarkColor: json["main_dark_color"],
        secondColor: json["second_color"],
        secondDarkColor: json["second_dark_color"],
        accentColor: json["accent_color"],
        accentDarkColor: json["accent_dark_color"],
        scaffoldDarkColor: json["scaffold_dark_color"],
        scaffoldColor: json["scaffold_color"],
      );

  Map<String, dynamic> toMap() => {
        "app_name": appName,
        "default_tax": defaultTax,
        "default_currency": defaultCurrency,
        "main_color": mainColor,
        "main_dark_color": mainDarkColor,
        "second_color": secondColor,
        "second_dark_color": secondDarkColor,
        "accent_color": accentColor,
        "accent_dark_color": accentDarkColor,
        "scaffold_dark_color": scaffoldDarkColor,
        "scaffold_color": scaffoldColor,
      };

  @override
  List<Object?> get props => [
        appName,
        defaultTax,
        defaultCurrency,
        mainColor,
        mainDarkColor,
        secondColor,
        secondDarkColor,
        accentColor,
        accentDarkColor,
        scaffoldDarkColor,
        scaffoldColor,
      ];
}
