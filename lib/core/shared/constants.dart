part of "imports.dart";

const int limit = 100;
const duration_20 = Duration(seconds: 20);
const duration_60 = Duration(seconds: 60);
const duration_120 = Duration(seconds: 120);
const double kIndent = 16;
const int firstPage = 0;
const int firstSet = 0;

final days = ["sat", "sun", "mon", "tue", "wen", "thu", "fri"];
const String pushNotification = "general_notification";

int get randomInt =>
    DateTime.now().microsecondsSinceEpoch * (Random().nextInt(4000));
