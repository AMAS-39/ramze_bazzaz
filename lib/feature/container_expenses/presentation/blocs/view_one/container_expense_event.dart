part of 'container_expense_bloc.dart';

abstract class OneContainerExpenseEvent extends Equatable {
  const OneContainerExpenseEvent();

  @override
  List<Object> get props => [];
}

class OneContainerExpenseGetEvent extends OneContainerExpenseEvent {
  final Map<String, String> params;
  final ShowMessage showMessage;
  final DataSource dataSource;
  final  int id;

  const OneContainerExpenseGetEvent(
      {required this.id,
      this.params = const {},
      this.showMessage = ShowMessage.none,
      this.dataSource = DataSource.remote})
      : super();
  @override
  @override
  List<Object> get props => [dataSource, params, showMessage];
}

class OneContainerExpenseRefreshEvent extends OneContainerExpenseEvent {
  final Map<String, String> params;
  final ShowMessage showMessage;
  final DataSource dataSource;
  final  int id;
  const OneContainerExpenseRefreshEvent(
      {required this.id,
      this.params = const {},
      this.showMessage = ShowMessage.none,
      this.dataSource = DataSource.remote});
  @override
  List<Object> get props => [dataSource, params, showMessage];
}
