part of "form_widgets.dart";

class GeneralTextFiled extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validate;
  final String? Function(String?)? onError;
  final Widget? prefixIcon;
  final Widget? prefix;
  final Widget? subfixIcon;
  final String? hintText;
  final String? labelText;
  final String? initialValue;

  final AutovalidateMode autovalidateMode;
  final int? maxLines;
  final int? maxLength;
  final double? borderWith;
  final Color? borderColor;
  final Color? fillColor;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final bool readOnly;
  final bool detectDer;
  final List<TextInputFormatter> inputFormatters;
  final bool obscureText;
  final bool? isDense;
  final double? borderRadius;
  final bool enable;
  final bool autofocus;
  final bool hasBorder;
  final TextAlign textAlign;
  final EdgeInsetsGeometry? contentPadding;
  final Function()? onTap;
  final Function(String)? onChange;
  final FocusNode? focusNode;
  final bool isRequired;
  final bool isLable;
  final bool isPhone;
  final bool filled;
  final void Function(String?)? onSubmit;
  const GeneralTextFiled(
      {super.key,
      required this.controller,
      this.inputFormatters = const [],
      this.detectDer = true,
      this.hasBorder = true,
      this.isDense,
      this.maxLength,
      this.filled = false,
      this.isPhone = false,
      this.isLable = false,
      this.isRequired = false,
      this.initialValue,
      this.labelText,
      this.textAlign = TextAlign.start,
      this.enable = true,
      this.keyboardType,
      this.onChange,
      this.hintStyle,
      this.fillColor,
      this.borderWith,
      this.onError,
      this.autofocus = false,
      this.prefix,
      this.style,
      this.borderColor,
      this.borderRadius,
      this.onSubmit,
      this.contentPadding,
      this.readOnly = false,
      this.obscureText = false,
      this.focusNode,
      this.autovalidateMode = AutovalidateMode.onUserInteraction,
      this.onTap,
      this.maxLines = 1,
      this.validate,
      this.subfixIcon,
      this.prefixIcon,
      this.hintText});

  @override
  State<GeneralTextFiled> createState() => _GeneralTextFiledState();
}

class _GeneralTextFiledState extends State<GeneralTextFiled> {
  TextDirection textDirection = sl<LocalAppSettingsCubit>().isEn == false
      ? TextDirection.rtl
      : TextDirection.ltr;
  void change(String? str) {
    if (checkIsNull(str)) {
      textDirection = sl<LocalAppSettingsCubit>().isEn == false
          ? TextDirection.rtl
          : TextDirection.ltr;
      setState(() {});
      return;
    }
    TextDirection temptextDirection = (str ?? "").textDirection;
    if (textDirection != temptextDirection) {
      textDirection = temptextDirection;
      setState(() {});
    }
  }

  @override
  void initState() {
    textDirection = checkIsNull(widget.controller?.text)
        ? Helper.i.context.textDirection
        : (widget.controller?.text ?? "").textDirection;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          cardColor: context.isDark ? Colors.black : Colors.white,
          platform: TargetPlatform.android),
      child: Row(
        children: [
          Expanded(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (widget.isLable)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: RichText(
                    text: TextSpan(text: "", children: [
                      TextSpan(
                          text: widget.labelText, style: context.style14W400B),
                      if (widget.isRequired)
                        TextSpan(
                            text: ' *',
                            style: context.style14W400B
                                .copyWith(color: Colors.red)),
                    ]),
                  ),
                ),
              TextFormField(
                  initialValue: widget.initialValue,
                  textDirection: textDirection,
                  autofocus: widget.autofocus,
                  controller: widget.controller,
                  onChanged: (value) {
                    if (widget.detectDer) {
                      change(value);
                    }
                    if (widget.isPhone) {
                    } else {
                      widget.onChange?.call(value);
                    }
                  },
                  maxLength: widget.maxLength,
                  focusNode: widget.focusNode,
                  enabled: widget.enable,
                  onSaved: widget.onSubmit,
                  onFieldSubmitted: widget.onSubmit,
                  inputFormatters: widget.inputFormatters,
                  keyboardType: widget.keyboardType,
                  maxLines: widget.maxLines,
                  textAlign: widget.textAlign,
                  textAlignVertical: context.isEn
                      ? TextAlignVertical.bottom
                      : TextAlignVertical.center,
                  // strutStyle: StrutStyle(
                  //     forceStrutHeight: false,
                  //     height: context.isEn ? 1.2 : 1.4),
                  style: (widget.style ?? context.style16W400B),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    widget.onError?.call(widget.validate!(value));

                    return widget.validate?.call(value);
                  },
                  readOnly: widget.readOnly,
                  obscureText: widget.obscureText,
                  onTap: () {
                    widget.onTap?.call();

                    if (widget.controller != null &&
                        widget.controller!.selection ==
                            TextSelection.fromPosition(TextPosition(
                                offset: widget.controller!.text.length - 1))) {
                      widget.controller!.selection = TextSelection.fromPosition(
                          TextPosition(offset: widget.controller!.text.length));
                    }
                  },
                  decoration: widget.hasBorder != true
                      ? InputDecoration(
                          isDense: widget.isDense,
                          alignLabelWithHint: true,
                          filled: widget.filled,
                          suffixIcon: widget.subfixIcon,
                          prefixIcon: widget.prefixIcon,
                          prefix: widget.prefix,
                          contentPadding: widget.contentPadding ??
                              const EdgeInsets.symmetric(
                                  horizontal: kIndent, vertical: 12),
                          fillColor: widget.fillColor ??
                              Theme.of(context).inputDecorationTheme.fillColor,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  widget.borderRadius ?? BORDER_RADUIS),
                              borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  widget.borderRadius ?? BORDER_RADUIS),
                              borderSide: BorderSide.none),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  widget.borderRadius ?? BORDER_RADUIS),
                              borderSide: BorderSide(
                                  width: widget.borderWith ?? 1,
                                  color: const Color(0XFFFB6340))),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  widget.borderRadius ?? BORDER_RADUIS),
                              borderSide: BorderSide(
                                  width: widget.borderWith ?? 1,
                                  color: const Color(0XFFFB6340))),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(
                                widget.borderRadius ?? BORDER_RADUIS),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(
                                widget.borderRadius ?? BORDER_RADUIS),
                          ),
                          label: widget.labelText == null || widget.isLable
                              ? null
                              : RichText(
                                  text: TextSpan(text: "", children: [
                                    TextSpan(
                                        text: widget.labelText,
                                        style: TextStyle(
                                            fontSize:
                                                widget.style?.fontSize ?? 14,
                                            color: AppColor.i.borderColor)),
                                    // if (widget.isRequired)
                                    //   const TextSpan(
                                    //       text: ' *',
                                    //       style: TextStyle(color: Colors.red)),
                                  ]),
                                ),
                          // labelText: widget.labelText,
                          // labelStyle: TextStyle(
                          //     fontSize: widget.style?.fontSize ?? 14,
                          //     color: AppColor.i.borderColor),
                          errorStyle: const TextStyle(
                              fontSize: 12, color: Color(0XFFFB6340)),
                          hintText: widget.hintText,
                          hintStyle: widget.hintStyle ??
                              TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.i.hintTextColor,
                                  fontSize: 14),
                        )
                      : InputDecoration(
                          isDense: widget.isDense,
                          alignLabelWithHint: true,
                          filled: widget.filled,
                          suffixIcon: widget.subfixIcon,
                          prefixIcon: widget.prefixIcon,
                          prefix: widget.prefix,
                          prefixIconColor: WidgetStateColor.resolveWith(
                              (states) => states.contains(WidgetState.focused)
                                  ? context.primaryColor
                                  : AppColor.i.foucedColor),
                          contentPadding: widget.contentPadding ??
                              const EdgeInsets.fromLTRB(15, 15, 15, 15),
                          fillColor: widget.fillColor ??
                              Theme.of(context).inputDecorationTheme.fillColor,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  widget.borderRadius ?? BORDER_RADUIS),
                              borderSide: BorderSide(
                                  width: widget.borderWith ?? 1,
                                  color: widget.borderColor ??
                                      Theme.of(context)
                                          .inputDecorationTheme
                                          .border
                                          ?.borderSide
                                          .color ??
                                      AppColor.i.borderColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  widget.borderRadius ?? BORDER_RADUIS),
                              borderSide: BorderSide(
                                  width: widget.borderWith ?? 1,
                                  color: widget.borderColor ??
                                      Theme.of(context)
                                          .inputDecorationTheme
                                          .focusedBorder
                                          ?.borderSide
                                          .color ??
                                      AppColor.i.borderColor)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  widget.borderRadius ?? BORDER_RADUIS),
                              borderSide: BorderSide(
                                  width: widget.borderWith ?? 1,
                                  color: const Color(0XFFFB6340))),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  widget.borderRadius ?? BORDER_RADUIS),
                              borderSide: BorderSide(
                                  width: widget.borderWith ?? 1,
                                  color: const Color(0XFFFB6340))),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  widget.borderRadius ?? BORDER_RADUIS),
                              borderSide: BorderSide(
                                  width: widget.borderWith ?? 1,
                                  color: widget.borderColor ??
                                      Theme.of(context)
                                          .inputDecorationTheme
                                          .disabledBorder
                                          ?.borderSide
                                          .color ??
                                      AppColor.i.borderColor)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: widget.borderWith ?? 1,
                                color: widget.borderColor ??
                                    Theme.of(context)
                                        .inputDecorationTheme
                                        .enabledBorder
                                        ?.borderSide
                                        .color ??
                                    AppColor.i.borderColor),
                            borderRadius: BorderRadius.circular(
                                widget.borderRadius ?? BORDER_RADUIS),
                          ),
                          label: widget.labelText == null || widget.isLable
                              ? null
                              : RichText(
                                  text: TextSpan(text: "", children: [
                                    if (widget.isRequired)
                                      TextSpan(
                                          text: widget.labelText,
                                          style: TextStyle(
                                              fontSize:
                                                  widget.style?.fontSize ?? 14,
                                              color: AppColor.i.borderColor)),
                                    if (widget.isRequired)
                                      const TextSpan(
                                          text: ' *',
                                          style: TextStyle(color: Colors.red)),
                                  ]),
                                ),
                          // labelText: widget.labelText,
                          // labelStyle: TextStyle(
                          //     fontSize: widget.style?.fontSize ?? 15,
                          //     color: AppColor.i.borderColor,
                          //     height: 1.4),
                          errorStyle: const TextStyle(
                              fontSize: 12, color: Color(0XFFFB6340)),
                          hintText: widget.hintText,
                          hintStyle: widget.hintStyle ??
                              TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.i.hintTextColor,
                                  fontSize: 14),
                        )),
            ],
          )),
        ],
      ),
    );
  }
}
