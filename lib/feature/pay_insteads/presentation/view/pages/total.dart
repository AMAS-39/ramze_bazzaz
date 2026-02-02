import 'package:app/core/shared/imports.dart';
import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget(
      {super.key,
      required this.title,
      required this.value,
      required this.icon});
  final String title;
  final String value;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2, top: 2),
      child: Row(
        children: [
          if (icon != null) Icon(icon, size: 18, color: Colors.grey.shade900),
          if (icon != null) const SizedBox(width: 6),
          SizedBox(
              // width: 80,
              child: Text("$title: ", style: context.style14W400B)),
          Text(value,
              style: context.style14W400B.copyWith(fontWeight: FontWeight.w500))
        ],
      ),
    );
  }
}
