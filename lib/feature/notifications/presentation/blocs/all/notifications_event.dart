part of 'notifications_bloc.dart';

class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class NotificationEmptyEvent extends NotificationEvent {
  const NotificationEmptyEvent();
}

class NotificationDeleteEvent extends NotificationEvent {
  final NotificationModel model;
  const NotificationDeleteEvent(this.model);
}

class NotificationMarkOneEvent extends NotificationEvent {
  final MarkNotificationAsReadModel model;
  const NotificationMarkOneEvent({required this.model});
}

class NotificationMarkAllEvent extends NotificationEvent {
  final MarkAllNotificationAsReadModel model;
  const NotificationMarkAllEvent({required this.model});
}

class NotificationLoadEvent extends NotificationEvent {
  final ShowMessage showMessage;
  final DataSource dataSource;
  final Function(LoadingMoreEvent)? onDone;
  final NotificationsFilterModel filters;
  final bool empty;
  final bool refresh;
  const NotificationLoadEvent(
      {required this.filters,
      this.onDone,
      this.empty = false,
      this.refresh = false,
      this.showMessage = ShowMessage.none,
      this.dataSource = DataSource.remote});
  @override
  List<Object?> get props => [dataSource, filters, showMessage, empty];
}
