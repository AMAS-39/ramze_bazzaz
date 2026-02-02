import 'package:flutter/material.dart';
import 'package:app/feature/slides/data/models/slide_details_model.dart';

class SlideDetailsWidget extends StatefulWidget {
  final SlideDetailsModel slide;

  const SlideDetailsWidget({super.key, required this.slide});

  @override
  State<SlideDetailsWidget> createState() {
    return _SlideDetailsWidgetState();
  }
}

class _SlideDetailsWidgetState extends State<SlideDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return const Text("data");
  }
}
