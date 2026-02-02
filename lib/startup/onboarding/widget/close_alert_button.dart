// ignore_for_file: use_build_context_synchronously

import 'package:app/core/shared/imports.dart';
import 'package:flutter/material.dart';

class CloseAlertButton extends StatelessWidget {
  const CloseAlertButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      top: -50,
      end: -50,
      child: InkWell(
          onTap: () {
            context.pop();
          },
          child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                  blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                shape: BoxShape.circle,
                // border:
                //     Border.all(width: 1.5, color: context.primaryColor),
                color: context.cardColor,
              ),
              child: Icon(
                Icons.clear,
                color: context.primaryColor,
              ))),
    );
  }
}
