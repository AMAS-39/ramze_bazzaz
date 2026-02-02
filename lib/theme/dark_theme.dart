import 'package:app/core/shared/imports.dart';
import 'package:flutter/material.dart';

String? getFontFamily() => "Poppins";
TextTheme _darkTextTheme() {
  return TextTheme(
      titleMedium: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 15,
          color: Colors.white,
          fontFamily: getFontFamily()),
      displayLarge: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 15,
          color: AppColor.i.colorDarkPrimary,
          fontFamily: getFontFamily()),
      bodyLarge: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 15,
          color: Colors.white,
          fontFamily: getFontFamily()),
      titleLarge: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 15,
          color: Colors.white,
          fontFamily: getFontFamily()),
      bodySmall: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 15,
          color: Colors.white,
          fontFamily: getFontFamily()),
      bodyMedium: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 15,
          color: Colors.grey[600],
          fontFamily: getFontFamily()));
}

Color _cardColor = Colors.grey.shade800;
ThemeData getDarkTheme() {
  return ThemeData(
      useMaterial3: false,
      brightness: Brightness.dark,
      fontFamily: getFontFamily(),
      cardTheme: CardThemeData(
          color: _cardColor,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(BORDER_RADUIS)))),
      platform: TargetPlatform.android,
      cardColor: _cardColor,
      iconTheme: const IconThemeData(color: Colors.white),
      dividerColor: Colors.grey[600],
      canvasColor: AppColor.i.scaffoldDarkColor,
      textSelectionTheme: const TextSelectionThemeData(),
      primaryColor: AppColor.i.colorDarkPrimary,
      dialogTheme: DialogThemeData(backgroundColor: AppColor.i.scaffoldDarkColor),
      bottomSheetTheme:
          BottomSheetThemeData(backgroundColor: AppColor.i.scaffoldDarkColor),
      buttonTheme: ButtonThemeData(
          buttonColor: AppColor.i.colorDarkPrimary,
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
      secondaryHeaderColor: AppColor.i.colorDarkPrimary,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              textStyle: WidgetStateProperty.all<TextStyle>(
                  const TextStyle(color: Colors.white)),
              backgroundColor:
                  WidgetStateProperty.all<Color>(AppColor.i.colorDarkPrimary))),
      scaffoldBackgroundColor: AppColor.i.scaffoldDarkColor,
      // scaffoldBackgroundColor: const Color(0XFFfafafa),
      appBarTheme: AppBarTheme(
          toolbarHeight: 60,
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColor.i.colorDarkPrimary,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
              fontFamily: getFontFamily(),
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white)),
      // appBarTheme: AppBarTheme(
      //     toolbarHeight: 60,
      //     elevation: 0,
      //     centerTitle: true,
      //     backgroundColor: Colors.grey[800],
      //     iconTheme: const IconThemeData(color: Colors.white),
      //     titleTextStyle: TextStyle(
      //         fontFamily: getFontFamily(),
      //         fontSize: 20,
      //         fontWeight: FontWeight.w500,
      //         color: Colors.white)),
      textTheme: _darkTextTheme(),
      primaryTextTheme: _darkTextTheme(),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          extendedTextStyle: const TextStyle(color: Colors.white),
          backgroundColor: AppColor.i.colorDarkPrimary),
      switchTheme: SwitchThemeData(
        thumbColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return null;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColor.i.colorDarkPrimary;
          }
          return null;
        }),
        trackColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return null;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColor.i.colorDarkPrimary;
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
            return AppColor.i.colorDarkPrimary;
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
            return AppColor.i.colorDarkPrimary;
          }
          return null;
        }),
      ),
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: AppColor.i.colorDarkPrimary,
      ));
}
