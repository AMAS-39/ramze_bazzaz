part of 'notifications_bloc.dart';

abstract class NotificationsState extends Equatable {
  bool get loadIsNot {
    return items.isEmpty && this is! NotificationsLoadingState;
  }

  List<NotificationModel> get items {
    if (this is NotificationsLoadedState) {
      return (this as NotificationsLoadedState).data;
    }
    return <NotificationModel>[];
  }

  const NotificationsState({this.metaModel = const MetaModel()});
  @override
  List<Object> get props => [];
  final MetaModel metaModel;

  @override
  String toString() => 'NotificationState(metaModel: $metaModel)';
}

class NotificationInitialState extends NotificationsState {
  @override
  List<Object> get props => [];
}

class NotificationsLoadingState extends NotificationsState {
  @override
  List<Object> get props => [];
}

class NotificationsLoadedState extends NotificationsState {
  final List<NotificationModel> data;
  const NotificationsLoadedState({
    required this.data,
    required super.metaModel,
  });
  @override
  List<Object> get props => [data, metaModel, randomInt];

  NotificationsLoadedState copyWith(
      {List<NotificationModel>? data, MetaModel? metaModel}) {
    return NotificationsLoadedState(
      metaModel: metaModel ?? this.metaModel,
      data: data ?? this.data,
    );
  }

  @override
  String toString() =>
      'NotificationLoadedState(data: $data ,metaModel:$metaModel)';
}

class NotificationsEmptyState extends NotificationsState {
  const NotificationsEmptyState();
  @override
  List<Object> get props => [];
}

class NotificationsErrorState extends NotificationsState {
  final Failure failure;
  const NotificationsErrorState({required this.failure});
  @override
  List<Object> get props => [failure];
}
