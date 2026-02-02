import 'package:app/core/model/reposne_list.dart';

class ResLocalList<T> {
  Map<String, dynamic> data;

  T Function(Map<String, dynamic> json) fromJsonModel;
  ResLocalList({required this.data, required this.fromJsonModel});
}

class ResLocalOne<T> {
  Map<String, dynamic> data;
  T Function(Map<String, dynamic> json) fromJsonModel;
  ResLocalOne({required this.data, required this.fromJsonModel});
}

ReponseList<T> parseLocalList<T>(ResLocalList<T> responseBody) {
  return ReponseList.fromMap(responseBody.data, responseBody.fromJsonModel,
      "data", responseBody.data, responseBody.data);
}

T parseLocalOne<T>(ResLocalOne<T> responseBody) {
  return responseBody.fromJsonModel(responseBody.data);
}
