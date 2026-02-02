part of 'payments_bloc.dart';

abstract class PaymentsState extends Equatable {
  bool get loadIsNot {
    return items.isEmpty && this is! PaymentsLoadingState;
  }

  List<PaymentModel> get items {
    if (this is PaymentsLoadedState) {
      return (this as PaymentsLoadedState).data;
    }
    return <PaymentModel>[];
  }

  const PaymentsState({this.metaModel = const MetaModel()});
  @override
  List<Object> get props => [];
  final MetaModel metaModel;

  @override
  String toString() => 'PaymentState(metaModel: $metaModel)';
}

class PaymentInitialState extends PaymentsState {
  @override
  List<Object> get props => [];
}

class PaymentsLoadingState extends PaymentsState {
  @override
  List<Object> get props => [];
}

class PaymentsLoadedState extends PaymentsState {
  final List<PaymentModel> data;
  const PaymentsLoadedState({
    required this.data,
    required super.metaModel,
  });
  @override
  List<Object> get props => [data, metaModel, randomInt];

  PaymentsLoadedState copyWith(
      {List<PaymentModel>? data, MetaModel? metaModel}) {
    return PaymentsLoadedState(
      metaModel: metaModel ?? this.metaModel,
      data: data ?? this.data,
    );
  }

  @override
  String toString() => 'PaymentLoadedState(data: $data ,metaModel:$metaModel)';
}

class PaymentsEmptyState extends PaymentsState {
  const PaymentsEmptyState();
  @override
  List<Object> get props => [];
}

class PaymentsErrorState extends PaymentsState {
  final Failure failure;
  const PaymentsErrorState({required this.failure});
  @override
  List<Object> get props => [failure];
}
