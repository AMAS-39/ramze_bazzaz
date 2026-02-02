import 'dart:async';
import 'dart:developer';

import 'package:app/core/shared/imports.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

enum IndicatorType {
  bottom,
  none,
  bottomEnd;
}

class MySlider extends StatefulWidget {
  const MySlider({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    required this.height,
    required this.width,
    required this.indicatorType,
    required this.indicator,
    this.indoctorWidth = 16,
    this.viewportFraction = 1,
    this.autoPlay = true,
    this.canMoveing = true,
  });
  final int itemCount;
  final double viewportFraction;
  final double? height;
  final double indoctorWidth;
  final double? width;
  final bool autoPlay;
  final bool canMoveing;
  final bool indicator;
  final IndicatorType indicatorType;
  final Widget Function(BuildContext, int) itemBuilder;
  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  late PageController _pageController;

  int current = 0;

  Timer? timer;
  @override
  void initState() {
    _pageController = PageController(viewportFraction: widget.viewportFraction);
    start();
    super.initState();
  }

  @override
  void dispose() {
    log("disposedisposedispose");
    try {
      timer?.cancel();
    } catch (e) {
      log(e.toString());
    }
    super.dispose();
  }

  void start() {
    timer?.cancel();
    if (!widget.autoPlay) {
      return;
    }
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      try {
        if (!_pageController.hasClients) {
          return;
        }
        final condition =
            (_pageController.page?.toInt() ?? 0) < widget.itemCount - 1;
        if (condition) {
          _pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.linear);
        } else {
          _pageController.animateToPage(0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.linearToEaseOut);
        }
      } catch (e) {
        logger("error in slider timer e");
      }
    });
  }

  Debouncer debouncer = Debouncer(delay: 5000);
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: (moveEvent) {
        timer?.cancel();
        debouncer.cancel();
        debouncer.run(() {
          start();
        });
      },
      child: Column(
        children: [
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                PageView.builder(
                    physics: widget.canMoveing
                        ? null
                        : const NeverScrollableScrollPhysics(),
                    onPageChanged: (value) {
                      if (value < widget.itemCount) {
                        current = value;
                        setState(() {});
                      }
                    },
                    controller: _pageController,
                    itemCount: widget.itemCount,
                    itemBuilder: widget.itemBuilder),
                // if (widget.indicatorType == IndicatorType.bottomEnd &&
                //     widget.indicator &&
                //     widget.itemCount > 1)
                PositionedDirectional(
                  bottom: 12,
                  end: 32,
                  child: SmoothPageIndicator(
                    count: widget.itemCount,
                    controller: _pageController,
                    onDotClicked: (index) {
                      _pageController.animateToPage(index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linearToEaseOut);
                    },
                    effect: WormEffect(
                        dotWidth: widget.indoctorWidth,
                        radius: 16,
                        spacing: 4,
                        dotHeight: 8,
                        strokeWidth: 8,
                        activeDotColor: context.primaryColor,
                        dotColor: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          // if (widget.indicatorType == IndicatorType.bottom &&
          //     widget.indicator &&
          //     widget.itemCount > 1)
          //   const SizedBox(height: 12),
          // if (widget.indicatorType == IndicatorType.bottom &&
          //     widget.indicator &&
          //     widget.itemCount > 1)
          //   SmoothPageIndicator(
          //     count: widget.itemCount,
          //     controller: _pageController,
          //     onDotClicked: (index) {
          //       _pageController.animateToPage(index,
          //           duration: const Duration(milliseconds: 500),
          //           curve: Curves.linearToEaseOut);
          //     },
          //     effect: WormEffect(
          //         dotWidth: widget.indoctorWidth,
          //         radius: 1.5,
          //         dotHeight: 4,
          //         activeDotColor: Colors.grey,
          //         dotColor: context.primaryColor),
          //   ),
        ],
      ),
    );
  }
}
