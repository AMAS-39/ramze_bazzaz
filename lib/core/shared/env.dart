// ignore_for_file: library_private_types_in_public_api

part of "imports.dart";

class Apps {
  static _Env stage = _Env(
    username: "rb3ys7c",
    password: "42890772",
    appName: "Ramze Bazzaz",
    primaryLightColor: const Color(0XFF284192),
    primaryDarkColor: const Color(0XFFf27227),
    logo: Assets.images.rbbLogo.path,
    app: App.rbb,
    fireabse: RbbDefaultFirebaseOptions(),
    test: true,
    url: "https://ramzebazzaz.azurewebsites.net",
  );
  static _Env rbb = _Env(
    test: false,
    app: App.rbb,
    fireabse: RbbDefaultFirebaseOptions(),
    primaryLightColor: const Color(0XFF284192),
    primaryDarkColor: const Color(0XFFf27227),
    logo: Assets.images.rbbLogo.path,
    appName: "Ramze Bazzaz",
    username: "rb3ys7c",
    password: "42890772",
    url: "https://ramzebazzaz.azurewebsites.net",
  );
  static _Env kostolog = _Env(
    test: false,
    fireabse: KostoDefaultFirebaseOptions(),
    appName: "Kosto Log",
    primaryLightColor: const Color(0XFF000166),
    primaryDarkColor: const Color(0XFF000166),
    logo: Assets.images.kostologLogo.path,
    app: App.kostolog,
    username: "rb3ys7c",
    password: "42890772",
    // url: "https://ramzebazzaz.azurewebsites.net");
    url: "https://kosto.azurewebsites.net",
  );
}

class _Env {
  String url;
  String password;
  String username;
  String logo;
  String appName;
  DefaultFirebaseOptions fireabse;
  bool test;
  Color primaryLightColor;
  Color primaryDarkColor;

  bool get isRbb => app == App.rbb;
  bool get isKostolog => app == App.kostolog;

  App app;
  _Env({
    required this.test,
    required this.username,
    required this.app,
    required this.fireabse,
    required this.logo,
    required this.primaryLightColor,
    required this.primaryDarkColor,
    required this.appName,
    required this.password,
    required this.url,
  });
}

_Env appConfig = Apps.stage;

enum App { rbb, kostolog }

extension AppExtension on App {
  bool get isRbb => this == App.rbb;
  bool get isKostolog => this == App.kostolog;
}
