import 'dart:convert';

import 'package:app/core/shared/imports.dart';
import 'package:flutter/material.dart';

class LocalAppSettingsState extends Equatable {
  final LanguageEnum lang;
  final ThemeMode themeMode;
  final bool reciveNotification;
  final bool showIntro;
  const LocalAppSettingsState({
    required this.lang,
    required this.themeMode,
    required this.showIntro,
    required this.reciveNotification,
  });

  LocalAppSettingsState copyWith({
    LanguageEnum? lang,
    ThemeMode? themeMode,
    bool? showIntro,
    bool? reciveNotification,
  }) {
    return LocalAppSettingsState(
      lang: lang ?? this.lang,
      showIntro: showIntro ?? this.showIntro,
      themeMode: themeMode ?? this.themeMode,
      reciveNotification: reciveNotification ?? this.reciveNotification,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lang': lang.name,
      'showIntro': showIntro,
      'themeMode': themeMode.index,
      'reciveNotification': reciveNotification,
    };
  }

  factory LocalAppSettingsState.fromMap(Map<String, dynamic> map) {
    return LocalAppSettingsState(
      lang: LanguageEnum.fromMap(checkIsNull(map['lang']) ? "en" : map['lang']),
      themeMode: ThemeMode.values[checkInt(map['themeMode'], defaultV: 1)],
      reciveNotification: checkBool(map['reciveNotification'], def: true),
      showIntro: checkBool(map['showIntro'], def: true),
    );
  }
  factory LocalAppSettingsState.defaultConst() {
    return const LocalAppSettingsState(
      lang: LanguageEnum.en,
      themeMode: ThemeMode.system,
      reciveNotification: true,
      showIntro: true,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalAppSettingsState.fromJson(String source) =>
      LocalAppSettingsState.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AppSettingsModel(lang: $lang, themeMode: $themeMode, showIntro: $showIntro, reciveNotification: $reciveNotification)';

  @override
  List<Object?> get props => [
        lang,
        showIntro,
        themeMode,
        reciveNotification,
      ];
}
