part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();
  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {
  @override
  List<Object> get props => [];
}

class LoadingAccountState extends AccountState {
  @override
  List<Object> get props => [];
}

class AccountLoadedState extends AccountState {
  final AccountModel data;
  const AccountLoadedState({required this.data});
  @override
  List<Object> get props => [data];
}

class AccountEmptyState extends AccountState {
  const AccountEmptyState();
}

class AccountErrorState extends AccountState {
  final Failure failure;
  const AccountErrorState({required this.failure});
  @override
  List<Object> get props => [failure];
}
