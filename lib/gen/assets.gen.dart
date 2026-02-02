/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsFlagsGen {
  const $AssetsFlagsGen();

  /// File path: assets/flags/iraq.png
  AssetGenImage get iraq => const AssetGenImage('assets/flags/iraq.png');

  /// File path: assets/flags/kurdistan.jpg
  AssetGenImage get kurdistan =>
      const AssetGenImage('assets/flags/kurdistan.jpg');

  /// File path: assets/flags/usa.webp
  AssetGenImage get usa => const AssetGenImage('assets/flags/usa.webp');

  /// List of all assets
  List<AssetGenImage> get values => [iraq, kurdistan, usa];
}

class $AssetsI18nGen {
  const $AssetsI18nGen();

  /// File path: assets/i18n/ar.json
  String get ar => 'assets/i18n/ar.json';

  /// File path: assets/i18n/en.json
  String get en => 'assets/i18n/en.json';

  /// File path: assets/i18n/ku.json
  String get ku => 'assets/i18n/ku.json';

  /// List of all assets
  List<String> get values => [ar, en, ku];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/delivery-truck-fast-svgrepo-com.svg
  String get deliveryTruckFastSvgrepoCom =>
      'assets/images/delivery-truck-fast-svgrepo-com.svg';

  /// File path: assets/images/img360.png
  AssetGenImage get img360 => const AssetGenImage('assets/images/img360.png');

  /// File path: assets/images/kosto_play_store_512.png
  AssetGenImage get kostoPlayStore512 =>
      const AssetGenImage('assets/images/kosto_play_store_512.png');

  /// File path: assets/images/kostolog_logo.png
  AssetGenImage get kostologLogo =>
      const AssetGenImage('assets/images/kostolog_logo.png');

  /// File path: assets/images/pay-money-icon.svg
  String get payMoneyIcon => 'assets/images/pay-money-icon.svg';

  /// File path: assets/images/payment-icon.svg
  String get paymentIcon => 'assets/images/payment-icon.svg';

  /// File path: assets/images/rbb_logo.png
  AssetGenImage get rbbLogo =>
      const AssetGenImage('assets/images/rbb_logo.png');

  /// File path: assets/images/rbb_play_store_512.png
  AssetGenImage get rbbPlayStore512 =>
      const AssetGenImage('assets/images/rbb_play_store_512.png');

  /// File path: assets/images/truck.svg
  String get truck => 'assets/images/truck.svg';

  /// List of all assets
  List<dynamic> get values => [
        deliveryTruckFastSvgrepoCom,
        img360,
        kostoPlayStore512,
        kostologLogo,
        payMoneyIcon,
        paymentIcon,
        rbbLogo,
        rbbPlayStore512,
        truck
      ];
}

class Assets {
  Assets._();

  static const $AssetsFlagsGen flags = $AssetsFlagsGen();
  static const $AssetsI18nGen i18n = $AssetsI18nGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
