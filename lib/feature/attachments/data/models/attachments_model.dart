import 'dart:convert';

import 'package:app/core/shared/imports.dart';

class AttachmentModel extends Equatable {
  final int id;
  final bool is360;
  final bool shareableForCustomer;
  final String title;
  final String? attachment;
  final FileType fileType;
  const AttachmentModel({
    required this.id,
    required this.is360,
    required this.shareableForCustomer,
    required this.title,
    required this.attachment,
    required this.fileType,
  });

  AttachmentModel copyWith({
    int? id,
    bool? is360,
    bool? shareableForCustomer,
    String? title,
    String? attachment,
    FileType? fileType,
  }) {
    return AttachmentModel(
      id: id ?? this.id,
      is360: is360 ?? this.is360,
      shareableForCustomer: shareableForCustomer ?? this.shareableForCustomer,
      title: title ?? this.title,
      attachment: attachment ?? this.attachment,
      fileType: fileType ?? this.fileType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'is360': is360,
      'shareableForCustomer': shareableForCustomer,
      'title': title,
      'attachment': attachment,
      'fileType': fileType.name,
    };
  }

  factory AttachmentModel.fromMap(Map<String, dynamic> map) {
    return AttachmentModel(
      id: map['id']?.toInt() ?? 0,
      is360: checkBool(map['is360']),
      shareableForCustomer: checkBool(map['shareableForCustomer']),
      title: map['title'] ?? '',
      attachment: formatAttachment(map['attachment']),
      fileType: FileType.fromMap(map['fileType']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AttachmentModel.fromJson(String source) =>
      AttachmentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AttachmentModel(id: $id, is360: $is360, shareableForCustomer: $shareableForCustomer, title: $title, attachment: $attachment, fileType: $fileType)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      is360,
      shareableForCustomer,
      title,
      attachment,
      fileType,
    ];
  }
}
