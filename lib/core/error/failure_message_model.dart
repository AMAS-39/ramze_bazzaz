import 'package:app/core/shared/imports.dart';

class FailureMessage {
  String reason;
  String message;
  int statusCode;
  FailureMessage(
      {required this.reason, required this.message, required this.statusCode});

  @override
  String toString() {
    return [message, reason]
        .where((element) => !checkIsNull(element))
        .toList()
        .join("\n");
  }

  FailureMessage copyWith({
    String? reason,
    String? message,
    int? statusCode,
  }) {
    return FailureMessage(
      reason: reason ?? this.reason,
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
    );
  }
}
