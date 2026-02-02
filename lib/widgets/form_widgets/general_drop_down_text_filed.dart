part of "form_widgets.dart";

class GeneralDropDownTextFiled<ValueType, ListType> extends StatelessWidget {
  final TextInputType textInputType;
  final String? Function(ValueType?)? validate;
  final Widget? prefixIcon;
  final Widget? subfixIcon;
  final List<ListType> list;
  final ValueType Function(ListType) getVal;
  final String Function(ListType)? getLabel;
  final ValueType? value;
  final double borderRadius;
  final double height;
  final Color? labelColor;
  final Color? fillColor;
  final Color? textColor;
  final Color? borderColor;
  final String? hintText;
  final String? labelText;
  final EdgeInsetsGeometry? contentPadding;
  final AutovalidateMode autovalidateMode;
  final int maxLines;
  final bool? isDense;
  final bool? readOnly;
  final bool isLable;
  final bool isRequired;
  final bool hasBorder;
  final bool? filled;

  final bool showLabel;
  final Function()? onTap;
  final Function(ValueType?)? onChange;
  const GeneralDropDownTextFiled(
      {super.key,
      required this.list,
      required this.getVal,
      this.showLabel = true,
      this.height = 1,
      this.getLabel,
      this.filled,
      this.labelText,
      this.readOnly = false,
      this.isRequired = false,
      this.isLable = false,
      this.hasBorder = true,
      this.contentPadding,
      this.fillColor,
      this.isDense,
      this.borderRadius = 12,
      this.borderColor,
      this.textInputType = TextInputType.text,
      required this.onChange,
      this.autovalidateMode = AutovalidateMode.onUserInteraction,
      this.onTap,
      this.labelColor,
      this.textColor,
      this.value,
      this.maxLines = 1,
      this.validate,
      this.subfixIcon,
      this.prefixIcon,
      this.hintText});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Theme(
      data: Theme.of(context).copyWith(platform: TargetPlatform.android),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (isLable)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: RichText(
                      text: TextSpan(text: "", children: [
                        TextSpan(text: labelText, style: context.style14W400B),
                        if (isRequired)
                          TextSpan(
                              text: ' *',
                              style: context.style14W400B
                                  .copyWith(color: Colors.red)),
                      ]),
                    ),
                  ),
                DropdownButtonFormField<ValueType>(
                  items: list.map((category) {
                    return DropdownMenuItem(
                        value: getVal(category),
                        child: Text(
                            "${getLabel != null ? getLabel!(category) : getVal(category)}"));
                  }).toList(),
                  onChanged: onChange,
                  style: TextStyle(
                      height: height,
                      color: textColor ?? theme.textTheme.bodyLarge?.color,
                      fontSize: 17.sp),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: validate,
                  initialValue: value,
                  decoration: hasBorder == true
                      ? InputDecoration(
                          suffixIcon: subfixIcon,
                          prefixIcon: prefixIcon,
                          label: labelText == null || isLable
                              ? null
                              : RichText(
                                  text: TextSpan(text: "", children: [
                                    if (isRequired)
                                      const TextSpan(
                                          text: '*',
                                          style: TextStyle(color: Colors.red)),
                                    TextSpan(
                                        text: labelText,
                                        style: TextStyle(
                                            color: AppColor.i.borderColor))
                                  ]),
                                ),
                          enabled: readOnly ?? true,
                          isDense: isDense,
                          filled: filled,
                          contentPadding: contentPadding ??
                              const EdgeInsets.fromLTRB(15, 15, 15, 15),
                          fillColor: fillColor ??
                              Theme.of(context).inputDecorationTheme.fillColor,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                              borderSide: BorderSide(
                                  color:
                                      borderColor ?? AppColor.i.borderColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                              borderSide: BorderSide(
                                  color:
                                      borderColor ?? AppColor.i.borderColor)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                              borderSide: BorderSide(
                                  color:
                                      borderColor ?? const Color(0XFFFB6340))),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                              borderSide: BorderSide(
                                  color:
                                      borderColor ?? const Color(0XFFFB6340))),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                              borderSide: BorderSide(
                                  color:
                                      borderColor ?? AppColor.i.borderColor)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: borderColor ?? AppColor.i.borderColor),
                            borderRadius: BorderRadius.circular(borderRadius),
                          ),
                          labelText: showLabel == true ? hintText : null,
                          labelStyle: TextStyle(
                              fontFamily: "",
                              fontSize: 17.sp,
                              color: labelColor ?? AppColor.i.borderColor),
                          errorStyle: const TextStyle(
                              fontFamily: "", color: Color(0XFFFB6340)),
                          hintText: showLabel == false ? '$hintText' : null,
                          hintStyle: TextStyle(
                              color: labelColor ??
                                  Theme.of(context).textTheme.bodyMedium?.color,
                              fontSize: 17.sp),
                        )
                      : InputDecoration(
                          isDense: isDense,
                          alignLabelWithHint: true,
                          filled: filled,
                          suffixIcon: subfixIcon,
                          prefixIcon: prefixIcon,
                          // prefixIconColor: MaterialStateColor.resolveWith(
                          //     (states) => states.contains(MaterialState.focused)
                          //         ? context.primaryColor
                          //         : AppColor.i.foucedColor),
                          contentPadding: contentPadding ??
                              const EdgeInsets.fromLTRB(15, 15, 15, 15),
                          fillColor: fillColor ??
                              Theme.of(context).inputDecorationTheme.fillColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none,
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none,
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none,
                          ),

                          label: labelText == null || isLable
                              ? null
                              : RichText(
                                  text: TextSpan(text: "", children: [
                                    if (isRequired)
                                      const TextSpan(
                                          text: '*',
                                          style: TextStyle(color: Colors.red)),
                                    TextSpan(
                                        text: labelText,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppColor.i.borderColor))
                                  ]),
                                ),
                          // labelText: labelText,
                          // labelStyle: TextStyle(
                          //     fontSize: style?.fontSize ?? 15,
                          //     color:  AppColor.i.borderColor,
                          //     height: 1.4),
                          errorStyle: const TextStyle(
                              fontSize: 12, color: Color(0XFFFB6340)),
                          hintText: hintText,
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
