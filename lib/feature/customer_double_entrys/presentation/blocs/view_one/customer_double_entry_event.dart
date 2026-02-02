part of 'customer_double_entry_bloc.dart';

abstract class OneCustomerDoubleEntryEvent extends Equatable {
  const OneCustomerDoubleEntryEvent();

  @override
  List<Object> get props => [];
}

class OneCustomerDoubleEntryGetEvent extends OneCustomerDoubleEntryEvent {
  final Map<String, String> params;
  final ShowMessage showMessage;
  final DataSource dataSource;
  final  int id;

  const OneCustomerDoubleEntryGetEvent(
      {required this.id,
      this.params = const {},
      this.showMessage = ShowMessage.none,
      this.dataSource = DataSource.remote})
      : super();
  @override
  @override
  List<Object> get props => [dataSource, params, showMessage];
}

class OneCustomerDoubleEntryRefreshEvent extends OneCustomerDoubleEntryEvent {
  final Map<String, String> params;
  final ShowMessage showMessage;
  final DataSource dataSource;
  final  int id;
  const OneCustomerDoubleEntryRefreshEvent(
      {required this.id,
      this.params = const {},
      this.showMessage = ShowMessage.none,
      this.dataSource = DataSource.remote});
  @override
  List<Object> get props => [dataSource, params, showMessage];
}
