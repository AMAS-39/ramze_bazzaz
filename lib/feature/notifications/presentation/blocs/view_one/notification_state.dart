part of 'notification_bloc.dart';

abstract class OneNotificationState extends Equatable {
  const OneNotificationState();
  @override
  List<Object?> get props => [];
}

class OneNotificationInitialState extends OneNotificationState {
  @override
  List<Object?> get props => [];
}

class OneNotificationLoadingState extends OneNotificationState {
  @override
  List<Object?> get props => [];
}

class OneNotificationLoadedState extends OneNotificationState {
  final NotificationDetalisModel data;
  const OneNotificationLoadedState({this.failure, required this.data});
  final Failure? failure;
  @override
  List<Object?> get props => [data, failure, DateTime.now()];
}

class OneNotificationEmptyState extends OneNotificationState {
  const OneNotificationEmptyState();

  @override
  List<Object> get props => [];
}

class OneNotificationErrorState extends OneNotificationState {
  final Failure failure;
  const OneNotificationErrorState({required this.failure});
  @override
  List<Object> get props => [failure];
}
