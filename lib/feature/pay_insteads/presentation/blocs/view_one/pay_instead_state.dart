part of 'pay_instead_bloc.dart';

abstract class OnePayInsteadState extends Equatable {
  const OnePayInsteadState();
  @override
  List<Object?> get props => [];
}

class OnePayInsteadInitialState extends OnePayInsteadState {
  @override
  List<Object?> get props => [];
}

class OnePayInsteadLoadingState extends OnePayInsteadState {
  @override
  List<Object?> get props => [];
}

class OnePayInsteadLoadedState extends OnePayInsteadState {
  final PayInsteadDetailsModel data;
  const OnePayInsteadLoadedState({this.failure, required this.data});
  final Failure? failure;
  @override
  List<Object?> get props => [data, failure, DateTime.now()];
}

class OnePayInsteadEmptyState extends OnePayInsteadState {
  const OnePayInsteadEmptyState();

  @override
  List<Object> get props => [];
}

class OnePayInsteadErrorState extends OnePayInsteadState {
  final Failure failure;
  const OnePayInsteadErrorState({required this.failure});
  @override
  List<Object> get props => [failure];
}
