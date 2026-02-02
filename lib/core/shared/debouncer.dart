part of "imports.dart";

class Debouncer {
  final int delay;
  Timer? _timer;
  Debouncer({this.delay = 500});
  void run(void Function() callBack) {
    cancel();
    _timer = Timer(Duration(milliseconds: delay), callBack);
  }

  void cancel() {
    _timer?.cancel();
  }
}
