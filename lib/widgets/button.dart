import 'package:app/core/shared/imports.dart';
import 'package:flutter/material.dart';

class GeneralButton extends StatelessWidget {
  const GeneralButton({
    super.key,
    required this.text,
    this.fontSize,
    this.txtColor,
    this.child,
    required this.onTap,
    this.color,
    this.borderWidth,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.padding,
    this.width,
    this.textHeight,
    this.radius,
    this.border = false,
  });
  final bool? border;
  final String text;
  final Widget? child;
  final String? icon;
  final VoidCallback? onTap;
  final Color? color;
  final Color? iconColor;
  final Color? txtColor;
  final double? fontSize;
  final double? iconSize;
  final double? width;
  final double? radius;
  final EdgeInsets? padding;
  final double? borderWidth;
  final double? textHeight;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ButtonStyle(

        // shadowColor: MaterialStateProperty.all<Color>(
        //     context.buttonColor ?? AppColor.buttonColor),
        elevation: WidgetStateProperty.all<double>(0),
        backgroundColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          logger("states $states");

          if (states.contains(WidgetState.disabled)) {
            return Colors.grey;
          } else if (states.contains(WidgetState.focused)) {
            return Colors.grey;
          } else if (states.contains(WidgetState.selected)) {
            return color ?? AppColor.i.colorLightPrimary;
          }
          return color ?? AppColor.i.colorLightPrimary;
        }),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius ?? BORDER_RADUIS),
                side: border == true
                    ? BorderSide(color: context.primaryColor)
                    : BorderSide.none)),
        padding: WidgetStateProperty.all<EdgeInsets>(padding ??
            const EdgeInsets.symmetric(vertical: 16, horizontal: 15)));

    return SizedBox(
        width: width,
        child: ElevatedButton(
            onPressed: onTap,
            style: style,
            child: Row(
              mainAxisAlignment: checkIsNull(icon)
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                child != null
                    ? child!
                    : Text(text,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        // strutStyle: const StrutStyle(
                        //     height: 1.5, forceStrutHeight: true),
                        style: TextStyle(
                            // height: textHeight,
                            color: txtColor ?? Colors.white,
                            fontSize: fontSize ?? 18.sp),
                        overflow: TextOverflow.ellipsis),
              ],
            )));
  }
}
