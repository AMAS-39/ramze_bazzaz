import 'dart:convert';

import 'package:app/core/shared/imports.dart';

class MetaModel extends Equatable {
  final int xTotalCount;
  final int xTotalSets;
  final Map<String, dynamic> header;
  final int pageSize;
  final int page;
  const MetaModel({
    this.xTotalCount = 0,
    this.xTotalSets = 0,
    this.page = firstPage,
    this.header = const {},
    this.pageSize = limit,
  });

  MetaModel copyWith({
    int? xTotalCount,
    int? xTotalSets,
    int? pageSize,
    int? page,
    Map<String, dynamic>? header,
  }) {
    return MetaModel(
      xTotalCount: xTotalCount ?? this.xTotalCount,
      xTotalSets: xTotalSets ?? this.xTotalSets,
      page: page ?? this.page,
      header: header ?? this.header,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'x-total-count': xTotalCount,
      'start': (page) * pageSize,
      // 'page': page,
      if (xTotalSets != 0) "set": xTotalSets,
      'end': (page + 1) * pageSize,
      "header": header,
      // 'pageSize': pageSize,
    };
  }

  factory MetaModel.fromMap(Map<String, dynamic> map) {
    logger(
        "MetaModel.fromMap ${map['x-total-sets']}   ${map['x-total-count']}");
    return MetaModel(
      header: map,
      xTotalCount: checkInt(
          "${map['x-total-count']}".replaceAll('[', '').replaceAll(']', '')),
      xTotalSets: checkInt(
          "${map['x-total-sets']}".replaceAll('[', '').replaceAll(']', '')),
      page: checkInt(map['page'], defaultV: firstPage),
      pageSize: checkInt(map['_pageSize'], defaultV: limit),
    );
  }

  String toJson() => json.encode(toMap());

  factory MetaModel.fromJson(String source) =>
      MetaModel.fromMap(json.decode(source));

  @override
  List<Object> get props => [xTotalCount, pageSize, xTotalSets];
  bool get deleteOldRecord => page == firstPage;

  @override
  String toString() =>
      'MetaModel(xTotalSets:$xTotalSets, xTotalCount: $xTotalCount, pageSize: $pageSize,_start: ${(page) * pageSize},  _end: ${(page + 1) * pageSize}, page:$page)';
}
