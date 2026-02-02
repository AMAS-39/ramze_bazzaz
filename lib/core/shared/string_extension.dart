part of "imports.dart";

String _translateFun(BuildContext? context, String str, bool? capital,
    {List<dynamic> args = const []}) {
  final currentContext = context ?? Helper.i.navigatorKey.currentContext;
  if (checkIsNull(AppLocalizations.of(currentContext!)?.translate(str))) {
    //Split key by uppercase letter and rejoin them
    final beforeCapitalLetter = RegExp(r"(?=[A-Z])");
    // logger("str $str args $args");
    var parts = str.split(beforeCapitalLetter);
    return "${parts.join(" ").toLowerCase().capitalize(capital)} ${args.join(" ")}";
  } else {
    String s =
        AppLocalizations.of(currentContext)!.translate(str).capitalize(capital);
    for (int i = 0; i < args.length; i++) {
      s = s.replaceFirst("_args", args[i]?.toString().toLowerCase() ?? "");
    }
    return s.replaceAll("_args", "");
  }
}

extension StringExtension on String {
  String removeSpaceToLowr() {
    return toLowerCase().replaceAll(" ", "");
  }

  String capitalize(bool? capital) {
    if (isEmpty || capital != true) {
      return this;
    }
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String trans({BuildContext? context, bool? capital, List<dynamic>? args}) {
    return _translateFun(context, this, capital ?? true, args: args ?? []);
  }

  String toHM() {
    List<String> timeComponents = split(':');

    return "${timeComponents[0]}:${timeComponents[1]}";
  }

  TimeOfDay toTimeOfDay() {
    List<String> timeComponents = split(':');
    int hour = int.parse(timeComponents[0]);
    int minute = int.parse(timeComponents[1]);

    return TimeOfDay(hour: hour, minute: minute);
  }

  TextDirection get textDirection {
    return Bidi.detectRtlDirectionality(this)
        ? TextDirection.rtl
        : TextDirection.ltr;
  }

  String get addZero => length == 1 ? "0$this" : this;
}
