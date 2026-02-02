part of "form_widgets.dart";

class DatePickerFiled extends StatefulWidget {
  const DatePickerFiled(
      {super.key,
      this.value,
      required this.isRequired,
      this.isLable = true,
      required this.labelText,
      required this.onChange});
  final DateTime? value;
  final bool isRequired;
  final bool isLable;

  final String labelText;
  final void Function(DateTime) onChange;
  @override
  State<DatePickerFiled> createState() => _DatePickerFiledState();
}

class _DatePickerFiledState extends State<DatePickerFiled> {
  DateTime? date;
  @override
  void initState() {
    date = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralTextFiled(
        filled: false,
        hasBorder: true,
        isLable: widget.isLable,
        isRequired: widget.isRequired,
        onTap: () async {
          final selected = await datePicker(
              selected: date,
              start: DateTime.now(),
              end: DateTime.now().add(const Duration(days: 365)));
          if (selected != null) {
            date = selected;
            widget.onChange.call(date!);

            setState(() {});
          }
        },
        validate: validateDate,
        readOnly: true,
        labelText: widget.labelText,
        controller: TextEditingController(text: date?.onlyDate ?? ""));
  }
}

class TimePickerFiled extends StatefulWidget {
  const TimePickerFiled(
      {super.key, this.value, required this.labelText, required this.onChange});
  final TimeOfDay? value;
  final String labelText;
  final void Function(TimeOfDay) onChange;
  @override
  State<TimePickerFiled> createState() => _TimePickerFiledState();
}

class _TimePickerFiledState extends State<TimePickerFiled> {
  TimeOfDay? date;
  @override
  void initState() {
    date = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralTextFiled(
        filled: true,
        hasBorder: false,
        isLable: true,
        validate: validateDate,
        onTap: () async {
          final selected = await showCustomeTimePicker(
            date,
          );
          if (selected != null) {
            date = selected;
            widget.onChange.call(date!);
            setState(() {});
          }
        },
        readOnly: true,
        labelText: widget.labelText,
        controller: TextEditingController(text: date?.toStr));
  }
}
