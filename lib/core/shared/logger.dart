part of "imports.dart";

void logger(dynamic message) {
  if (kDebugMode) {
    // print(StackTrace.current);
    // log('$message');
    print('\x1B[33m$message');
  }
}
