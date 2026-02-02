part of 'customer_info_bloc.dart';

abstract class CustomerInfoState extends Equatable {
  const CustomerInfoState();
  @override
  List<Object> get props => [];
}

class CustomerInfoInitial extends CustomerInfoState {
  @override
  List<Object> get props => [];
}

class LoadingCustomerInfoState extends CustomerInfoState {
  @override
  List<Object> get props => [];
}

class CustomerInfoLoadedState extends CustomerInfoState {
  final CustomerInfoModel data;
  const CustomerInfoLoadedState({required this.data});
  @override
  List<Object> get props => [data];
}

class CustomerInfoEmptyState extends CustomerInfoState {
  const CustomerInfoEmptyState();
  @override
  List<Object> get props => [];
}

class CustomerInfoErrorState extends CustomerInfoState {
  final Failure failure;
  const CustomerInfoErrorState({required this.failure});
  @override
  List<Object> get props => [failure];
}
