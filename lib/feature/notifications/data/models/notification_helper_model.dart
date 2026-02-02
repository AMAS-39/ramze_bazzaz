import 'package:app/core/shared/imports.dart';

class NotificationHelperModel {
  final NotificationType type;
  final String title;
  final String? subTitle;
  final int jobId;
  NotificationHelperModel({
    required this.type,
    required this.title,
    this.subTitle,
    required this.jobId,
  });

  NotificationHelperModel copyWith({
    NotificationType? type,
    String? title,
    String? subTitle,
    int? jobId,
  }) {
    return NotificationHelperModel(
      type: type ?? this.type,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      jobId: jobId ?? this.jobId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type.name,
      'title': title,
      'subTitle': subTitle,
      'job_id': jobId,
    };
  }

  factory NotificationHelperModel.fromMap(Map<String, dynamic> map) {
    return NotificationHelperModel(
      type: NotificationType.fromMap(map['type']),
      title: map['title'] ?? '',
      subTitle: map['subTitle'],
      jobId: checkInt(map['job_id']),
    );
  }

  @override
  String toString() {
    return 'NotificationHelperModel(type: $type, title: $title, subTitle: $subTitle, job_id: $jobId)';
  }
}
