part of 'pay_instead_bloc.dart';

abstract class OnePayInsteadEvent extends Equatable {
  const OnePayInsteadEvent();

  @override
  List<Object> get props => [];
}

class OnePayInsteadGetEvent extends OnePayInsteadEvent {
  final Map<String, String> params;
  final ShowMessage showMessage;
  final DataSource dataSource;
  final  int id;

  const OnePayInsteadGetEvent(
      {required this.id,
      this.params = const {},
      this.showMessage = ShowMessage.none,
      this.dataSource = DataSource.remote})
      : super();
  @override
  @override
  List<Object> get props => [dataSource, params, showMessage];
}

class OnePayInsteadRefreshEvent extends OnePayInsteadEvent {
  final Map<String, String> params;
  final ShowMessage showMessage;
  final DataSource dataSource;
  final  int id;
  const OnePayInsteadRefreshEvent(
      {required this.id,
      this.params = const {},
      this.showMessage = ShowMessage.none,
      this.dataSource = DataSource.remote});
  @override
  List<Object> get props => [dataSource, params, showMessage];
}
