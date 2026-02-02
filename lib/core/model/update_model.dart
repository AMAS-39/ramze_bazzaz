import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class UpdateModel extends Equatable {
  final bool update;
  final String linkGoogle;
  final String linkIos;
  const UpdateModel({
    required this.update,
    required this.linkGoogle,
    required this.linkIos,
  });
  //Get update link bases on  platform
  String get link => kIsWeb ?"":Platform.isAndroid ? linkGoogle : linkIos;
  UpdateModel copyWith({
    bool? update,
    String? linkGoogle,
    String? linkIos,
  }) {
    return UpdateModel(
      update: update ?? this.update,
      linkGoogle: linkGoogle ?? this.linkGoogle,
      linkIos: linkIos ?? this.linkIos,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'update': update,
      'link_google': linkGoogle,
      'link_ios': linkIos,
    };
  }

  factory UpdateModel.fromMap(Map<String, dynamic> map) {
    return UpdateModel(
      update: map['update'] ?? false,
      linkGoogle: map['link_google'] ?? '',
      linkIos: map['link_ios'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateModel.fromJson(String source) =>
      UpdateModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'UpdateModel(update: $update, link_google: $linkGoogle, link_ios: $linkIos)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UpdateModel &&
        other.update == update &&
        other.linkGoogle == linkGoogle &&
        other.linkIos == linkIos;
  }

  @override
  int get hashCode => update.hashCode ^ linkGoogle.hashCode ^ linkIos.hashCode;

  @override
  List<Object> get props => [update, linkGoogle, linkIos];
}
