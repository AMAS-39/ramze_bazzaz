import 'package:app/core/shared/imports.dart';

class Language {
  final LanguageEnum code;
  final String name;
  final String flag;

  Language(
    this.code,
    this.name,
    this.flag,
  );
}

List<Language> languages = [
  Language(LanguageEnum.en, "English", Assets.flags.usa.path),
  Language(LanguageEnum.ku, "کوردی", Assets.flags.kurdistan.path),
  Language(LanguageEnum.ar, "العربية", Assets.flags.iraq.path),
];
