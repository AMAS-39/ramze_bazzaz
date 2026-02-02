part of "imports.dart";

extension ContextExtension on BuildContext {
  void pop([dynamic value]) {
    if (Navigator.of(this).canPop()) {
      Navigator.pop(this, value);
    }
  }

  Color get primaryColor => Theme.of(this).primaryColor;
  Color get greyLine => const Color(0XFFEBEBEB);
  Color get borderColor => Theme.of(this).dividerColor;
  Color get ligthGrey => const Color(0XFFF9F8F8);
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  Color get iconColor => Theme.of(this).iconTheme.color!;
  Color get canvacColor => Theme.of(this).canvasColor;
  Color get cardColor =>
      Theme.of(this).cardTheme.color ?? Theme.of(this).cardColor;
  TextDirection get textDirection => Directionality.of(this);
  bool get isEn {
    return textDirection == TextDirection.ltr;
  }

  Color get alertBackColor => isDark ? cardColor : scaffoldBackgroundColor;
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;
  Color? get buttonColor =>
      Theme.of(this).elevatedButtonTheme.style?.backgroundColor?.resolve({});
  Color? get buttonTextColor =>
      Theme.of(this).elevatedButtonTheme.style?.textStyle?.resolve({})?.color;

  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  double get longestSide => MediaQuery.of(this).size.longestSide;
  double get shortestSide => MediaQuery.of(this).size.shortestSide;

  Color get iconBtnColor => primaryColor;
  Color get dividerColor => Theme.of(this).dividerColor;

  TextStyle get style20W600B {
    return TextStyle(
        color: titleStyle.color,
        fontFamily: getFontFamily(),
        fontSize: 20,
        fontWeight: FontWeight.w600);
  }

  TextStyle get style16W600B {
    return TextStyle(
        color: titleStyle.color,
        fontFamily: getFontFamily(),
        fontSize: 16,
        fontWeight: FontWeight.w600);
  }

  TextStyle get style16W500B {
    return TextStyle(
        color: titleStyle.color,
        fontFamily: getFontFamily(),
        fontSize: 16,
        fontWeight: FontWeight.w500);
  }

  TextStyle get style18W600B {
    return TextStyle(
        color: titleStyle.color,
        fontFamily: getFontFamily(),
        fontSize: 18,
        fontWeight: FontWeight.w600);
  }

  TextStyle get style18W500B {
    return TextStyle(
        color: titleStyle.color,
        fontFamily: getFontFamily(),
        fontSize: 18,
        fontWeight: FontWeight.w500);
  }

  TextStyle get style16W400B {
    return TextStyle(
        color: titleStyle.color,
        fontFamily: getFontFamily(),
        fontSize: 16,
        fontWeight: FontWeight.w400);
  }

  TextStyle get style20W400B {
    return TextStyle(
        color: titleStyle.color,
        fontFamily: getFontFamily(),
        fontSize: 20,
        fontWeight: FontWeight.w400);
  }

  TextStyle get style16W400R {
    return TextStyle(
        color: primaryColor,
        fontFamily: getFontFamily(),
        fontSize: 16,
        fontWeight: FontWeight.w400);
  }

  /// BLack 18 600W
  TextStyle get style18W400B {
    return TextStyle(
        color: titleStyle.color,
        fontFamily: getFontFamily(),
        fontSize: 18,
        fontWeight: FontWeight.w400);
  }

  /// BLack 14 600W
  TextStyle get style14W400B {
    return TextStyle(
        color: titleStyle.color,
        fontFamily: getFontFamily(),
        fontSize: 14,
        fontWeight: FontWeight.w400);
  }

  TextStyle get style12W500B {
    return TextStyle(
        color: titleStyle.color,
        fontFamily: getFontFamily(),
        fontSize: 12,
        fontWeight: FontWeight.w500);
  }

  TextStyle get style12W500 {
    return TextStyle(
        color: subTitleStyle.color,
        fontFamily: getFontFamily(),
        fontSize: 12,
        fontWeight: FontWeight.w500);
  }

  TextStyle get style14W500B {
    return TextStyle(
        color: titleStyle.color,
        fontFamily: getFontFamily(),
        fontSize: 14,
        fontWeight: FontWeight.w500);
  }

  TextStyle get style12W400B {
    return TextStyle(
        color: titleStyle.color,
        fontFamily: getFontFamily(),
        fontSize: 12,
        fontWeight: FontWeight.w400);
  }

  TextStyle get style24W600 {
    return TextStyle(
        color: titleStyle.color,
        fontFamily: getFontFamily(),
        fontSize: 24,
        fontWeight: FontWeight.w600);
  }

  TextStyle get style14W500 {
    return TextStyle(
        color: subTitleStyle.color,
        fontFamily: getFontFamily(),
        fontSize: 14,
        fontWeight: FontWeight.w500);
  }

  TextStyle get style14W400 {
    return TextStyle(
        color: subTitleStyle.color,
        fontFamily: getFontFamily(),
        fontSize: 14,
        fontWeight: FontWeight.w400);
  }

  TextStyle get style14W400R {
    return TextStyle(
        color: primaryColor,
        fontFamily: getFontFamily(),
        fontSize: 14,
        fontWeight: FontWeight.w400);
  }

  TextStyle get style14W600B {
    return TextStyle(
        color: titleStyle.color,
        fontFamily: getFontFamily(),
        fontSize: 14,
        fontWeight: FontWeight.w600);
  }

  TextStyle get style14W700R {
    return TextStyle(
        color: primaryColor,
        fontFamily: getFontFamily(),
        fontSize: 14,
        fontWeight: FontWeight.w700);
  }

  TextStyle get style14W600 {
    return TextStyle(
        color: subTitleStyle.color,
        fontFamily: getFontFamily(),
        fontSize: 14,
        fontWeight: FontWeight.w600);
  }

  TextStyle get style10W400 {
    return TextStyle(
        color: subTitleStyle.color,
        fontFamily: getFontFamily(),
        fontSize: 10,
        fontWeight: FontWeight.w400);
  }

  TextStyle get style12W400 {
    return TextStyle(
        color: subTitleStyle.color,
        fontFamily: getFontFamily(),
        fontSize: 12,
        fontWeight: FontWeight.w400);
  }

  TextStyle get style14W600R {
    return TextStyle(
        color: primaryColor,
        fontFamily: getFontFamily(),
        fontSize: 14,
        fontWeight: FontWeight.w600);
  }

  TextStyle get style12W600 {
    return TextStyle(
        color: subTitleStyle.color,
        fontFamily: getFontFamily(),
        fontSize: 12,
        fontWeight: FontWeight.w600);
  }

  TextStyle get titleStyle {
    return (Theme.of(this).textTheme.bodyLarge ??
            const TextStyle(color: Colors.black))
        .copyWith(fontSize: 17, fontWeight: FontWeight.normal);
  }

  TextStyle get appBarTitleStyle {
    return (Theme.of(this).appBarTheme.titleTextStyle ??
            const TextStyle(color: Colors.black))
        .copyWith(fontSize: 18);
  }

  TextStyle get headLine1 =>
      (Theme.of(this).textTheme.displayLarge ?? const TextStyle())
          .copyWith(fontSize: 20);
  TextStyle get subTitleStyle =>
      (Theme.of(this).textTheme.bodySmall ?? const TextStyle())
          .copyWith(fontSize: 15, fontWeight: FontWeight.w400);
  Future<T?> to<T>(Widget widget,
      {bool withCup = false, bool checkLogin = false}) async {
    if (checkLogin) {
      if (sl<AccountBloc>().info == null) {
        return Helper.i.context.to(const LoginScreen(
          isFromTabScreen: false,
        ));
      }
    }
    withCup = withCup || kIsWeb || Platform.isIOS;

    if (withCup != true) {
      return await Navigator.push(
          this, MaterialPageRoute(builder: (_) => widget));
    } else {
      {
        return await Navigator.push(
            this, CupertinoPageRoute(builder: (_) => widget));
      }
    }
  }

  void toAndRemove(Widget widget, {bool withCup = true}) {
    withCup = withCup || kIsWeb || Platform.isIOS;
    if (withCup == false) {
      Navigator.pushAndRemoveUntil(
          this, MaterialPageRoute(builder: (_) => widget), (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          this, CupertinoPageRoute(builder: (_) => widget), (route) => false);
    }
  }

  void toReplace(Widget widget, {bool withCup = true}) {
    withCup = withCup || kIsWeb || Platform.isIOS;
    if (withCup == false) {
      Navigator.pushReplacement(
          this, MaterialPageRoute(builder: (_) => widget));
    } else {
      Navigator.pushReplacement(
          this, CupertinoPageRoute(builder: (_) => widget));
    }
  }

  bool get isLandScane =>
      MediaQuery.of(this).orientation == Orientation.landscape;
  Size get size => MediaQuery.of(this).size;
}

extension TextExtension on Text {
  Widget get autoDir {
    return Directionality(
      textDirection: (data ?? "").textDirection,
      child: this,
    );
  }
}
