import 'dart:convert';

import 'package:app/core/shared/imports.dart';

String parseServerError(String? res, String def, int? statusCode) {
  try {
    if (statusCode == 403) {
      return Trans.youHaveNotPermissonToDoThat.trans();
    } else if (statusCode == 405) {
      return Trans.notAllowed.trans();
    } else if (statusCode == 400) {
      var body = jsonDecode("$res");
      String err = "";
      var error = (body['errors'] as Map);
      error.forEach((key, value) {
        err = "$err ${value.join(", ")}";
      });
      if (!checkIsNull(err)) {
        return err;
      }
    }
    var body = jsonDecode("$res");
    var message = body['message'] ?? body['messages'];
    if (message == null) {
      return def;
    } else if (message is String) {
      return message;
    } else if (message is List) {
      return message.join(" ");
    }

    return "${message ?? def}";
  } catch (e) {
    try {
      String error = res ?? def;
      return error;
    } catch (e) {
      return def;
    }
  }
}
