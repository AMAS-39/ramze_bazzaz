import 'package:app/core/shared/imports.dart';
import 'package:flutter/material.dart';

class TitleWithArrow extends StatelessWidget {
  const TitleWithArrow({super.key, required this.title, required this.onTap, this.color, this.icon});
  final String title;
  final Function()? onTap;
  final Color? color;
  final IconData ?icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kIndent / 2),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: kIndent / 2, horizontal: kIndent),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: context.style16W400B
                      .copyWith(color:color?? context.titleStyle.color)),
               Icon(
              icon??  Icons.arrow_forward_ios,
                size: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
