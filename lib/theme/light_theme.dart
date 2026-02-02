import 'package:app/core/shared/imports.dart';
import 'package:app/theme/dark_theme.dart';
import 'package:flutter/material.dart';

TextTheme _lightTextTheme() {
  return TextTheme(
      titleMedium: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 15,
          color: Colors.black,
          fontFamily: getFontFamily()),
      displayLarge: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 15,
          color: AppColor.i.colorLightPrimary,
          fontFamily: getFontFamily()),
      bodyLarge: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 15,
          color: const Color(0XFF0D0D26),
          fontFamily: getFontFamily()),
      titleLarge: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 15,
          color: Colors.black,
          fontFamily: getFontFamily()),
      bodyMedium: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 15,
          color: Colors.grey[600],
          fontFamily: getFontFamily()));
}

const _cardColor = Colors.white;
// const _cardColor = Color(0XFFf9f9fb);
ThemeData getLightTheme() {
  // return  FlexThemeData.light(scheme: FlexScheme.greenM3);
  return ThemeData(
      useMaterial3: false,
      brightness: Brightness.light,
      fontFamily: getFontFamily(),
      // iconTheme: IconThemeData(color: AppColor.i.colorLightPrimary),
      cardTheme: CardThemeData(
          color: _cardColor,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(BORDER_RADUIS)))),
      platform: TargetPlatform.android,
      // splashColor: Colors.transparent,
      // hoverColor: Colors.transparent,
      // focusColor: Colors.transparent,
      // highlightColor: Colors.transparent,
      cardColor: _cardColor,
      dividerColor: Colors.grey.shade400,
      canvasColor: const Color.fromARGB(255, 241, 241, 241),
      textSelectionTheme: const TextSelectionThemeData(),
      primaryColor: AppColor.i.colorLightPrimary,
      dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
      bottomSheetTheme:
          const BottomSheetThemeData(backgroundColor: Colors.white),
      buttonTheme: ButtonThemeData(
          buttonColor: AppColor.i.colorLightPrimary,
          textTheme: ButtonTextTheme.normal),
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(BORDER_RADUIS),
              borderSide: BorderSide(color: AppColor.i.borderColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(BORDER_RADUIS),
              borderSide: BorderSide(color: AppColor.i.borderColor)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(BORDER_RADUIS),
              borderSide: const BorderSide(color: Color(0XFFFB6340))),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(BORDER_RADUIS),
              borderSide: const BorderSide(color: Color(0XFFFB6340))),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(BORDER_RADUIS),
              borderSide: BorderSide(color: AppColor.i.borderColor)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.i.borderColor),
            borderRadius: BorderRadius.circular(BORDER_RADUIS),
          ),
          fillColor: Colors.grey[300]),
      secondaryHeaderColor: AppColor.i.colorLightPrimary,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              textStyle: WidgetStateProperty.all<TextStyle>(
                  const TextStyle(color: Colors.white)),
              backgroundColor: WidgetStateProperty.all<Color>(
                  AppColor.i.colorLightPrimary))),
      scaffoldBackgroundColor: AppColor.i.scaffoldBgLightColor,
      // scaffoldBackgroundColor: const Color(0XFFfafafa),
      appBarTheme: AppBarTheme(
          toolbarHeight: 60,
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColor.i.colorLightPrimary,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
              fontFamily: getFontFamily(),
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white)),
      textTheme: _lightTextTheme(),
      primaryTextTheme: _lightTextTheme(),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          extendedTextStyle: const TextStyle(color: Colors.white),
          backgroundColor: AppColor.i.colorLightPrimary),
      switchTheme: SwitchThemeData(
        thumbColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return null;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColor.i.colorLightPrimary;
          }
          return null;
        }),
        trackColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return null;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColor.i.colorLightPrimary;
          }
          return null;
        }),
      ),
      radioTheme: RadioThemeData(
        fillColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return null;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColor.i.colorLightPrimary;
          }
          return null;
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return null;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColor.i.colorLightPrimary;
          }
          return null;
        }),
      ),
      colorScheme: ColorScheme.light(
        secondary: AppColor.i.colorLightPrimary,
        primary: AppColor.i.colorLightPrimary,
      ).copyWith(surface: Colors.grey.withOpacity(0.3)));
}
