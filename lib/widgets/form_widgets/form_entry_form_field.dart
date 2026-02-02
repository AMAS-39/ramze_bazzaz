part of "form_widgets.dart";

typedef FormChildBuilder<T> = Widget Function(Function(T) changeHandler);

class FormEntryFormField<T> extends FormField<T> {
  final FormChildBuilder<T> child;
  final double? width;
  final EdgeInsetsGeometry? padding;
  @override
  // ignore: overridden_fields
  final T initialValue;
  FormEntryFormField(
      {super.key,
      required this.child,
      this.width,
      this.padding,
      required this.initialValue,
      required FormFieldValidator<T> validator,
      required FormFieldSetter<T> onSaved})
      : super(
            initialValue: initialValue,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            builder: (field) {
              void onChangedHandler(value) {
                field.didChange(value);
              }

              return SizedBox(
                width: width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    child(onChangedHandler),
                    field.hasError
                        ? Padding(
                            padding: padding ??
                                const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 0),
                            child: Text(
                              field.errorText ?? "",
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 12),
                            ),
                          )
                        : Container()
                  ],
                ),
              );
            },
            onSaved: onSaved,
            validator: validator);
}
