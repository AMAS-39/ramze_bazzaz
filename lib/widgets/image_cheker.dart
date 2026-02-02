// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:app/core/shared/imports.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageChecker extends StatelessWidget {
  const ImageChecker({
    super.key,
    required this.imageUrl,
    this.errorImage,
    this.fit,
    this.width,
    this.memCacheHeight,
    this.backGroundColor,
    this.color,
    this.padding,
    this.memCacheWidth,
    this.placeholder,
    this.errorPlaceholder,
    this.cacheKey,
    this.onLoad,
    this.radius = 0,
    this.height,
  });
  final String? imageUrl;
  final Color? backGroundColor;
    final Function(ImageSize height)? onLoad;

  final Color? color;
  final BoxFit? fit;
  final String? errorImage;
  final String? cacheKey;
  final double? width, height;
  final int? memCacheWidth, memCacheHeight;
  final double radius;
  final Widget? placeholder;
  final Widget? errorPlaceholder;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    logger("imageUrl $imageUrl");

    if (checkIsNull(imageUrl) == false &&
        imageUrl?.contains("/") == true &&
        imageUrl?.startsWith("http") == false) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: backGroundColor,
              borderRadius: BorderRadius.circular(radius),
            ),
            child: Image.file(File(imageUrl!),
                fit: fit, height: height, width: width),
          ));
    }
    bool isEmpty =
        checkIsNull(imageUrl) || imageUrl?.startsWith("http") != true;
    final tt = errorImage ?? appConfig.logo;
    return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: backGroundColor,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: isEmpty
              ? (errorPlaceholder ??
                  (tt.endsWith("svg")
                      ? SvgPicture.asset(tt,
                          fit: fit ?? BoxFit.contain,
                          height: height,
                          width: width)
                      : Image.asset(tt,
                          fit: fit, height: height, width: width)))
              : imageUrl!.endsWith("svg")
                  ? SvgChecker(
                      imageUrl: imageUrl,
                      tempImageUrl: errorImage,
                      backGroundColor: backGroundColor,
                      color: color,
                      fit: fit,
                      width: width,
                      errorImage: errorImage,
                      cacheKey: cacheKey,
                      memCacheWidth: memCacheWidth,
                      radius: radius,
                      placeholder: placeholder,
                      errorPlaceholder: errorPlaceholder,
                    )
                  : CachedNetworkImage(
                      memCacheHeight: memCacheHeight,
                      fadeInDuration: const Duration(milliseconds: 1),
                      fadeOutDuration: const Duration(milliseconds: 1),
                      fadeInCurve: Curves.ease,
                      color: color,
                      cacheKey: cacheKey,
                      fadeOutCurve: Curves.ease,
                      placeholderFadeInDuration:
                          const Duration(milliseconds: 1),
                      memCacheWidth: memCacheWidth,
                      imageUrl: imageUrl!,
                      imageBuilder: onLoad == null
                          ? null
                          : (context, imageProvider) {
                              imageProvider
                                  .getBytes(context,
                                      format: ImageByteFormat.png)
                                  .then((imageBytes) {
                                if (imageBytes != null) {
                                  onLoad!(imageBytes);
                                }
                              });

                              return SizedBox(
                                child: Image(
                                  image: imageProvider,
                                  fit: fit,
                                  width: width,
                                  height: height,
                                ),
                              );
                            },
                      progressIndicatorBuilder: (context, url, progress) {
                        return SizedBox(
                            width: width,
                            height: height,
                            child: placeholder ??
                                ImageLoaderWidget(
                                    radius: 0, height: height, width: width));
                      },
                      errorWidget: (context, url, error) {
                        return errorPlaceholder ??
                            Container(
                              child: (errorPlaceholder ??
                                  (tt.endsWith("svg")
                                      ? SvgPicture.asset(tt,
                                          fit: fit ?? BoxFit.contain,
                                          height: height,
                                          width: width)
                                      : Image.asset(tt,
                                          fit: fit,
                                          height: height,
                                          width: width))),
                            );
                      },
                      fit: fit,
                      width: width,
                      height: height),
        ));
  }
}

class ImageLoaderWidget extends StatelessWidget {
  const ImageLoaderWidget(
      {required this.width,
      required this.height,
      required this.radius,
      super.key});

  final double? width;
  final double? height;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}

class SvgChecker extends StatelessWidget {
  const SvgChecker({
    super.key,
    required this.imageUrl,
    this.tempImageUrl,
    this.errorImage,
    this.fit,
    this.width,
    this.memCacheHeight,
    this.backGroundColor,
    this.color,
    this.memCacheWidth,
    this.placeholder,
    this.errorPlaceholder,
    this.cacheKey,
    this.radius = 0,
    this.height,
  });
  final String? imageUrl;
  final String? tempImageUrl;
  final Color? backGroundColor;
  final Color? color;
  final BoxFit? fit;
  final String? errorImage;
  final String? cacheKey;
  final double? width, height;
  final int? memCacheWidth, memCacheHeight;
  final double radius;
  final Widget? placeholder;
  final Widget? errorPlaceholder;

  @override
  Widget build(BuildContext context) {
    bool isEmpty = checkIsNull(imageUrl) || imageUrl?.contains("http") != true;
    logger("imageUrl $imageUrl");

    return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: isEmpty
            ? (errorPlaceholder ??
                ImageLoaderWidget(
                  radius: radius,
                  height: height,
                  width: width,
                ))
            : SvgPicture.network(
                imageUrl!,
                color: color,
                placeholderBuilder: (context) {
                  return SizedBox(
                    width: width,
                    height: height,
                    child: placeholder ??
                        ImageLoaderWidget(
                            radius: null, height: height, width: width),
                  );
                },
                fit: fit ?? BoxFit.none,
                width: width,
                height: height,
              ));
  }
}
class ImageSize {
  final int? width;
  final int? height;
  ImageSize({this.width, this.height});

  @override
  String toString() => 'ImageSize(width: $width, height: $height)';
}
extension ImageTool on ImageProvider {
  Future<ImageSize?> getBytes(BuildContext context,
      {ImageByteFormat format = ImageByteFormat.rawRgba}) async {
    final imageStream = resolve(createLocalImageConfiguration(context));
    final Completer<ImageSize> completer = Completer<ImageSize>();
    final ImageStreamListener listener = ImageStreamListener(
      (imageInfo, synchronousCall) async {
        final bytes = ImageSize(
            width: imageInfo.image.width, height: imageInfo.image.height);
        if (!completer.isCompleted) {
          completer.complete(bytes);
        }
      },
    );
    imageStream.addListener(listener);
    final imageBytes = await completer.future;
    imageStream.removeListener(listener);
    return imageBytes;
  }
}
