import 'package:equatable/equatable.dart';

class NotificationsFilterModel extends Equatable {
  const NotificationsFilterModel();
  @override
  List<Object?> get props => [];

  NotificationsFilterModel copyWith() {
    return const NotificationsFilterModel();
  }

  Map<String, dynamic> toMap() {
    return {};
  }

  factory NotificationsFilterModel.fromMap(Map<String, dynamic> map) {
    return const NotificationsFilterModel();
  }

  @override
  String toString() => 'NotificationsFilterModel()';
}
