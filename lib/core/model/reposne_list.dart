import 'package:app/core/shared/imports.dart';

class ReponseList<T> {
  final MetaModel meta;
  final Map<String, dynamic> header;
  final List<T> data;
  ReponseList({
    required this.meta,
    required this.data,
    required this.header,
  });
  factory ReponseList.fromMap(
    Map<String, dynamic> map,
    T Function(Map<String, dynamic> json) fromJsonModel,
    String key,
    Map<String, dynamic> header,
    Map<String, dynamic> params,
  ) {
    logger("key $key ${map[key]}");
    return ReponseList(
      meta: MetaModel.fromMap({
        ...params,
        ...header,
      }),
      header: header,
      data: List<T>.from(map[key].map((itemsJson) => fromJsonModel(itemsJson))),
    );
  }
}

// class ListResponse<T> {
//   final List<T> data;
//   final int total;
//   final int perPage;
//   ListResponse({
//     required this.data,
//     required this.perPage,
//     required this.total,
//   });

//   factory ListResponse.fromJson({
//     required Map<String, dynamic> json,
//     required T Function(Map<String, dynamic> json) fromJsonModel,
//   }) {
//     return ListResponse(
//         data: List<T>.from(
//             json["data"].map((itemsJson) => fromJsonModel(itemsJson))),
//         total: json["total"] ?? json["meta"]?["total"] ?? 0,
//         perPage: json["per_page"] ?? json["meta"]?["per_page"] ?? 0);
//   }
// }
class BehavesWithTotal<T, S> {
  final MetaModel meta;
  final Map<String, dynamic> header;
  final S totals;
  final List<T> data;
  BehavesWithTotal({
    required this.meta,
    required this.data,
    required this.header,
    required this.totals,
  });
}
