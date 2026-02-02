part of 'slide_bloc.dart';

abstract class OneSlideEvent extends Equatable {
  const OneSlideEvent();

  @override
  List<Object> get props => [];
}

class OneSlideGetEvent extends OneSlideEvent {
  final Map<String, String> params;
  final ShowMessage showMessage;
  final DataSource dataSource;
  final  int id;

  const OneSlideGetEvent(
      {required this.id,
      this.params = const {},
      this.showMessage = ShowMessage.none,
      this.dataSource = DataSource.remote})
      : super();
  @override
  @override
  List<Object> get props => [dataSource, params, showMessage];
}

class OneSlideRefreshEvent extends OneSlideEvent {
  final Map<String, String> params;
  final ShowMessage showMessage;
  final DataSource dataSource;
  final  int id;
  const OneSlideRefreshEvent(
      {required this.id,
      this.params = const {},
      this.showMessage = ShowMessage.none,
      this.dataSource = DataSource.remote});
  @override
  List<Object> get props => [dataSource, params, showMessage];
}
