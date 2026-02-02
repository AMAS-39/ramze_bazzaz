part of 'customer_double_entry_bloc.dart';

abstract class OneCustomerDoubleEntryState extends Equatable {
  const OneCustomerDoubleEntryState();
  @override
  List<Object?> get props => [];
}

class OneCustomerDoubleEntryInitialState extends OneCustomerDoubleEntryState {
  @override
  List<Object?> get props => [];
}

class OneCustomerDoubleEntryLoadingState extends OneCustomerDoubleEntryState {
  @override
  List<Object?> get props => [];
}

class OneCustomerDoubleEntryLoadedState extends OneCustomerDoubleEntryState {
  final CustomerDoubleEntryDetailsModel data;
  const OneCustomerDoubleEntryLoadedState({this.failure, required this.data});
  final Failure? failure;
  @override
  List<Object?> get props => [data, failure, DateTime.now()];
}

class OneCustomerDoubleEntryEmptyState extends OneCustomerDoubleEntryState {
  const OneCustomerDoubleEntryEmptyState();

  @override
  List<Object> get props => [];
}

class OneCustomerDoubleEntryErrorState extends OneCustomerDoubleEntryState {
  final Failure failure;
  const OneCustomerDoubleEntryErrorState({required this.failure});
  @override
  List<Object> get props => [failure];
}
