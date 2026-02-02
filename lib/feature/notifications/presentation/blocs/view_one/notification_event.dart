part of 'notification_bloc.dart';

abstract class OneNotificationEvent extends Equatable {
  const OneNotificationEvent();

  @override
  List<Object> get props => [];
}

class OneNotificationGetEvent extends OneNotificationEvent {
  final Map<String, String> params;
  final ShowMessage showMessage;
  final DataSource dataSource;
  final String id;

  const OneNotificationGetEvent(
      {required this.id,
      this.params = const {},
      this.showMessage = ShowMessage.none,
      this.dataSource = DataSource.remote})
      : super();
  @override
  @override
  List<Object> get props => [dataSource, params, showMessage];
}

class OneNotificationRefreshEvent extends OneNotificationEvent {
  final Map<String, String> params;
  final ShowMessage showMessage;
  final DataSource dataSource;
  final int id;
  const OneNotificationRefreshEvent(
      {required this.id,
      this.params = const {},
      this.showMessage = ShowMessage.none,
      this.dataSource = DataSource.remote});
  @override
  List<Object> get props => [dataSource, params, showMessage];
}
