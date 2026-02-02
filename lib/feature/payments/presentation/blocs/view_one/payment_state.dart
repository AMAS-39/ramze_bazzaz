part of 'payment_bloc.dart';

abstract class OnePaymentState extends Equatable {
  const OnePaymentState();
  @override
  List<Object?> get props => [];
}

class OnePaymentInitialState extends OnePaymentState {
  @override
  List<Object?> get props => [];
}

class OnePaymentLoadingState extends OnePaymentState {
  @override
  List<Object?> get props => [];
}

class OnePaymentLoadedState extends OnePaymentState {
  final PaymentDetailsModel data;
  const OnePaymentLoadedState({this.failure, required this.data});
  final Failure? failure;
  @override
  List<Object?> get props => [data, failure, DateTime.now()];
}

class OnePaymentEmptyState extends OnePaymentState {
  const OnePaymentEmptyState();

  @override
  List<Object> get props => [];
}

class OnePaymentErrorState extends OnePaymentState {
  final Failure failure;
  const OnePaymentErrorState({required this.failure});
  @override
  List<Object> get props => [failure];
}
