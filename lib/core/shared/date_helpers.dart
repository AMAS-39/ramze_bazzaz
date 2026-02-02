part of "imports.dart";

extension DateTimeExtension on DateTime {
  String get formatDate {
    try {
      String year = this.year.toString();
      String day = this.day.toString();
      String month = this.month.toString();
      String hour = (this.hour > 12 ? this.hour - 12 : this.hour).addZero;
      return "$hour:$minute ${this.hour > 12 ? Trans.pm.trans() : Trans.am.trans()} $day-$month-$year";
    } catch (e) {
      logger("formatDate error $e");
      return "";
    }
  }

  String get onlyDate {
    try {
      return "$year-${month.addZero}-${day.addZero}";
    } catch (e) {
      logger("formatDate error $e");
      return "";
    }
  }

  String get yearAndMonth {
    try {
      return "${monthsName[month].trans()} $year";
    } catch (e) {
      logger("formatDate error $e");
      return "";
    }
  }

  bool get isToday {
    DateTime now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  DateTime addTimeToDate(TimeOfDay? timeOfDay) {
    try {
      logger(timeOfDay);
      DateTime dateTime = DateTime(year, month, day);
      if (timeOfDay != null) {
        dateTime = dateTime
            .add(Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute));
        return dateTime;
      }
      return dateTime;
    } catch (e) {
      return DateTime(year, month, day);
    }
  }

  String get getChatMessage {
    if (isToday) {
      return getTime;
    }
    return getShortDateTime;
  }

  String get getShortDateTime {
    try {
      int hour = (this.hour > 12 ? this.hour - 12 : this.hour);
      String per = this.hour > 12 ? Trans.pm.trans() : Trans.am.trans();
      final String tt =
          "${day.addZero}-${month.addZero} ${hour.addZero}:${minute.addZero} $per";
      return tt;
    } catch (e) {
      logger("formatDate error $e");
      return "";
    }
  }

  String get getTime {
    try {
      int hour = (this.hour > 12 ? this.hour - 12 : this.hour);
      String per = this.hour > 12 ? Trans.pm.trans() : Trans.am.trans();
      final String tt = "${hour.addZero}:${minute.addZero} $per";
      logger("tt $tt");
      return tt;
    } catch (e) {
      logger("formatDate error $e");
      return "";
    }
  }
}

extension TimeOfDayExtension on TimeOfDay {
  String get toStr => "${hour.toString().addZero}:${minute.toString().addZero}";

  Duration calculateDuration(TimeOfDay time2) {
    DateTime dateTime1 = DateTime(2023, 1, 1, hour, minute);
    DateTime dateTime2 = DateTime(2023, 1, 1, time2.hour, time2.minute);

    if (dateTime2.isBefore(dateTime1)) {
      dateTime2 = dateTime2.add(const Duration(days: 1));
    }

    return dateTime2.difference(dateTime1);
  }
}

extension DurationExtension on Duration {
  String formatDuration() {
    logger("message $this");
    String twoDigitMinutes = '${inMinutes.remainder(60)}'.padLeft(2, '0');
    String twoDigitHours = '$inHours'.padLeft(2, '0');

    return "$twoDigitHours:$twoDigitMinutes";
  }
}

bool deosStart(DateTime? dateTime) {
  if (dateTime == null) {
    return true;
  }
  return DateTime.now().isAfter(dateTime);
}

List<String> monthsName = [
  "jan",
  "feb",
  "mar",
  "apr",
  "may",
  "jun",
  "jul",
  "aug",
  "sep",
  "oct",
  "nov",
  "dec"
];
int getTodayIndex() {
  //     [0, 1, 2, 3, 4, 5, 6]
  return [6, 7, 1, 2, 3, 4, 5].indexOf(DateTime.now().weekday);
}

String get getTodayName => Days.all[getTodayIndex()];
