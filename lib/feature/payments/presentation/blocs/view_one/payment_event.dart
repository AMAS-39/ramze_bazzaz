part of 'payment_bloc.dart';

abstract class OnePaymentEvent extends Equatable {
  const OnePaymentEvent();

  @override
  List<Object> get props => [];
}

class OnePaymentGetEvent extends OnePaymentEvent {
  final Map<String, String> params;
  final ShowMessage showMessage;
  final DataSource dataSource;
  final  int id;

  const OnePaymentGetEvent(
      {required this.id,
      this.params = const {},
      this.showMessage = ShowMessage.none,
      this.dataSource = DataSource.remote})
      : super();
  @override
  @override
  List<Object> get props => [dataSource, params, showMessage];
}

class OnePaymentRefreshEvent extends OnePaymentEvent {
  final Map<String, String> params;
  final ShowMessage showMessage;
  final DataSource dataSource;
  final  int id;
  const OnePaymentRefreshEvent(
      {required this.id,
      this.params = const {},
      this.showMessage = ShowMessage.none,
      this.dataSource = DataSource.remote});
  @override
  List<Object> get props => [dataSource, params, showMessage];
}
