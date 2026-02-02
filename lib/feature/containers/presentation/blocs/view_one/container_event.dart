part of 'container_bloc.dart';

abstract class OneContainerEvent extends Equatable {
  const OneContainerEvent();

  @override
  List<Object> get props => [];
}


class OneContainerReinitEvent extends OneContainerEvent {}
class OneContainerGetEvent extends OneContainerEvent {
  final Map<String, String> params;
  final ShowMessage showMessage;
  final DataSource dataSource;
  final  String id;

  const OneContainerGetEvent(
      {required this.id,
      this.params = const {},
      this.showMessage = ShowMessage.none,
      this.dataSource = DataSource.remote})
      : super();
  @override
  @override
  List<Object> get props => [dataSource, params, showMessage];
}

class OneContainerRefreshEvent extends OneContainerEvent {
  final Map<String, String> params;
  final ShowMessage showMessage;
  final DataSource dataSource;
  final  int id;
  const OneContainerRefreshEvent(
      {required this.id,
      this.params = const {},
      this.showMessage = ShowMessage.none,
      this.dataSource = DataSource.remote});
  @override
  List<Object> get props => [dataSource, params, showMessage];
}
