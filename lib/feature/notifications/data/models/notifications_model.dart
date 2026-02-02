import 'package:app/core/shared/imports.dart';

import 'notification_helper_model.dart';

class NotificationModel extends Equatable {
  final String id;
  final NotificationType type;
  final NotificationData data;
  final DateTime? readAt;
  final DateTime createdAt;
  NotificationHelperModel get toNotificationHelper {
    return NotificationHelperModel(
      type: (type),
      title: data.title ?? "",
      jobId: 0,
    );
  }

  const NotificationModel({
    required this.id,
    required this.type,
    required this.data,
    required this.readAt,
    required this.createdAt,
  });

  NotificationModel copyWith({
    String? id,
    NotificationType? type,
    NotificationData? data,
    DateTime? readAt,
    DateTime? createdAt,
  }) =>
      NotificationModel(
        id: id ?? this.id,
        type: type ?? this.type,
        data: data ?? this.data,
        readAt: readAt ?? this.readAt,
        createdAt: createdAt ?? this.createdAt,
      );

  factory NotificationModel.fromMap(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        type: NotificationType.fromMap(json["type"]),
        data: NotificationData.fromMap(json["data"]),
        readAt: DateTime.tryParse(json["read_at"] ?? ""),
        createdAt: DateTime.parse(json["created_at"] ?? ""),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type.name,
        "data": data.toMap(),
        "read_at": readAt?.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        id,
        type,
        data,
        readAt,
        createdAt,
      ];
}

class NotificationData extends Equatable {
  final String? title;
  final String? url;

  const NotificationData({
    required this.title,
    required this.url,
  });

  NotificationData copyWith({
    String? title,
    String? url,
  }) =>
      NotificationData(
        title: title ?? this.title,
        url: url ?? this.url,
      );

  factory NotificationData.fromMap(Map<String, dynamic> json) =>
      NotificationData(
        title: json["title"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "url": url,
      };

  @override
  List<Object?> get props => [
        url,
        title,
      ];
}
