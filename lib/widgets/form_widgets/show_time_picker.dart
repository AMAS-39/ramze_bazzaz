part of "form_widgets.dart";


Future<TimeOfDay?> showCustomeTimePicker(TimeOfDay? selected) async {
  return await showTimePicker(
    context: Helper.i.context,
    initialTime: selected ??   TimeOfDay.now(),
  );
}
