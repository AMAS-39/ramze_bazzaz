import 'package:app/core/shared/imports.dart';
import 'package:app/localization/app_local.dart';
import 'package:app/localization/kurdish_ios_local.dart';
import 'package:app/localization/kurdish_local.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Locale getLocale(LanguageEnum? lang) {
  if (lang == LanguageEnum.ku) {
    return const Locale('ku');
  } else if (lang == LanguageEnum.ar) {
    return const Locale('ar');
  } else {
    return const Locale('en', 'US');
  }
}

const List<Locale> supportedLocales = [
  Locale('en', "US"),
  Locale('ar'),
  Locale('ku')
];
const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
  AppLocalizations.delegate,
  CkbWidgetLocalizations.delegate,
  CkbMaterialLocalizations.delegate,
  KurdishCupertinoLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  DefaultCupertinoLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
];
