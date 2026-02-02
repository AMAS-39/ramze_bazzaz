import 'dart:convert';

import 'package:app/core/shared/imports.dart';

class ResRemote<T> {
  String body;
  Map<String, dynamic> header;
  Map<String, dynamic> params;
  ParseBody parseBody;

  T Function(Map<String, dynamic> json) fromJsonModel;
  ResRemote(
      {required this.body,
      required this.fromJsonModel,
      required this.header,
      required this.params,
      required this.parseBody});
}

ReponseList<T> parseBodyList<T>(ResRemote<T> responseBody) {
  final body = jsonDecode(responseBody.body);

  return ReponseList.fromMap(
    responseBody.parseBody == ParseBody.direct
        ? {"direct": body}
        : responseBody.parseBody == ParseBody.data
            ? body["data"]
            : body,
    responseBody.fromJsonModel,
    responseBody.parseBody.name,
    responseBody.header,
    responseBody.params,
  );
}

T? parseBodyOne<T>(ResRemote<T> responseBody) {
  if (responseBody.runtimeType == ResRemote<UnitModel>) {
    return UnitModel.fromMap(const {}) as T;
  }
  final body = jsonDecode(responseBody.body);

  return responseBody.fromJsonModel(
      responseBody.parseBody == ParseBody.direct ? {"data": body} : body);
}
