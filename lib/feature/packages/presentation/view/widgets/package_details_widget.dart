import 'package:flutter/material.dart';
import 'package:app/feature/packages/data/models/package_details_model.dart';

class PackageDetailsWidget extends StatefulWidget {
  final PackageDetailsModel package;

  const PackageDetailsWidget({super.key, required this.package});

  @override
  State<PackageDetailsWidget> createState() {
    return _PackageDetailsWidgetState();
  }
}

class _PackageDetailsWidgetState extends State<PackageDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return const Text("data");
  }
}
