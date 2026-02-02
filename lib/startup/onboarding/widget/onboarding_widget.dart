import 'package:app/core/shared/imports.dart';
import 'package:flutter/material.dart';

class OnboardingWidget extends StatelessWidget {
  final String title, imagePath, mainText;
  final double imageSize;
  const OnboardingWidget(
      {super.key,
      required this.imagePath,
      required this.mainText,
      required this.imageSize,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 70.h),
        Center(
          child: Image.asset(imagePath,
              fit: BoxFit.contain, height: imageSize, width: imageSize),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kIndent, vertical: kIndent),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kIndent),
                child: Text(
                  title,
                  // textAlign: TextAlign.center,
                  style: context.style20W600B.copyWith(fontSize: 28),
                ),
              ),
              const SizedBox(height: 34),
              Text(
                mainText,
                style: context.style14W400B.copyWith(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      ],
    );
  }
}
