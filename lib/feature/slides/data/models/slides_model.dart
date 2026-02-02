import 'dart:convert';

import 'package:app/core/shared/imports.dart';

class SlideModel extends Equatable {
  final int id;
  final int sort;
  final String? name;
  final String? message;
  final String? attachment;
  final bool isAvailable;
  const SlideModel({
    required this.id,
    required this.sort,
    this.name,
    this.message,
    this.attachment,
    required this.isAvailable,
  });

  SlideModel copyWith({
    int? id,
    int? sort,
    String? name,
    String? message,
    String? attachment,
    bool? isAvailable,
  }) {
    return SlideModel(
      id: id ?? this.id,
      sort: sort ?? this.sort,
      name: name ?? this.name,
      message: message ?? this.message,
      attachment: attachment ?? this.attachment,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sort': sort,
      'name': name,
      'message': message,
      'attachment': attachment,
      'isAvailable': isAvailable,
    };
  }

  factory SlideModel.fromMap(Map<String, dynamic> map) {
    return SlideModel(
      id: checkInt(map['id']),
      sort: checkInt(map['sort']),
      name: map['name'],
      message: map['message'],
      attachment: formatAttachment(map['attachment']),
      isAvailable: checkBool(map['isAvailable']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SlideModel.fromJson(String source) =>
      SlideModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SlideModel(id: $id, sort: $sort, name: $name, message: $message, attachment: $attachment, isAvailable: $isAvailable)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      sort,
      name,
      message,
      attachment,
      isAvailable,
    ];
  }
}
