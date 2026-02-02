// ignore_for_file: non_constant_identifier_names

part of "../../core/shared/imports.dart";

double BORDER_RADUIS = appConfig.app == App.rbb ? 12 : 20;

class AppColor {
  static final AppColor _singleton = AppColor._();
  static AppColor get i => _singleton;
  AppColor._();

  //Blue Darl Color
  Color get _primaryLightColor => appConfig.primaryLightColor;
  Color get _primaryDarkColor => appConfig.app == App.kostolog
      ? appConfig.primaryLightColor
      : appConfig.primaryDarkColor;
  final Color greyTypeColor = const Color(0XFFA1A1AA);
  final Color foucedColor = const Color(0XFFFEE0E5);
  final Color greyLineColor = const Color(0XFFEBEBEB);
  final Color blackTypeColor = const Color(0XFF333333);
  final Color dividrColor = const Color(0XFFF6F6F6);
  final Color hintTextColor = const Color(0XFFD4D4D8);
  final Color lightGrey = const Color(0XFFEEEEEE);
  final Color lightGrey2 = const Color(0XFFF9F8F8);
  final Color lightRedColor = const Color(0XFFFEEFF2);
  final Color catCardColor = const Color(0XFFf5f5f5);
  final Color _darkCardColor = const Color(0XFF252525);
  final Color _darkScaffoldColor = const Color(0XFF2c2c2c);
  final _lightcardColor = const Color(0XFFFFFFFF);
  final Color textFillColor = const Color(0xFFc0c1c6);
  final borderColor = const Color(0XFFD4D4D8);
  final discoverOnShamleBorderColor = const Color(0XFFF1F1F1);
  SettingDataModel? get settingsModel => null;
  Color get colorDarkPrimary {
    return getColor(settingsModel?.mainDarkColor, _primaryDarkColor);
  }

  Color get scaffoldDarkColor {
    return getColor(settingsModel?.scaffoldDarkColor, _darkScaffoldColor);
  }

  Color get accentDarkColor {
    return getColor(settingsModel?.mainDarkColor, _primaryLightColor);
  }

  Color get secondDarkColor {
    return getColor(settingsModel?.secondDarkColor, _darkCardColor);
  }

  Color get colorLightPrimary {
    return getColor(settingsModel?.mainColor, _primaryLightColor);
  }

  Color get scaffoldBgLightColor {
    return const Color(0XFFfafafd);
    // return Colors.white;
    // return getColor(settingsModel?.scaffoldColor, _lightScaffoldColor);
  }

  Color get accentLightColor {
    return getColor(settingsModel?.mainColor, _primaryLightColor);
  }

  Color get cardColor {
    return getColor(settingsModel?.secondColor, _lightcardColor);
  }
}

Color getColor(String? colorString, Color defaultColor) {
  try {
    return defaultColor;
    // logger("colorString $colorString");
    // return colorString?.toColor() ?? defaultColor;
  } catch (e) {
    logger("error in parse color $e");
    return defaultColor;
  }
}
