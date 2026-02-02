part of 'pay_insteads_bloc.dart';

abstract class PayInsteadsState extends Equatable {
  bool get loadIsNot {
    return items.isEmpty && this is! PayInsteadsLoadingState;
  }

  List<PayInsteadModel> get items {
    if (this is PayInsteadsLoadedState) {
      return (this as PayInsteadsLoadedState).data;
    }
    return <PayInsteadModel>[];
  }

  const PayInsteadsState({this.metaModel = const MetaModel()});
  @override
  List<Object> get props => [];
  final MetaModel metaModel;

  @override
  String toString() => 'PayInsteadState(metaModel: $metaModel)';
}

class PayInsteadInitialState extends PayInsteadsState {
  @override
  List<Object> get props => [];
}

class PayInsteadsLoadingState extends PayInsteadsState {
  @override
  List<Object> get props => [];
}

class PayInsteadsLoadedState extends PayInsteadsState {
  final List<PayInsteadModel> data;
  const PayInsteadsLoadedState({
    required this.data,
    required super.metaModel,
  });
  @override
  List<Object> get props => [data, metaModel, randomInt];

  PayInsteadsLoadedState copyWith(
      {List<PayInsteadModel>? data, MetaModel? metaModel}) {
    return PayInsteadsLoadedState(
      metaModel: metaModel ?? this.metaModel,
      data: data ?? this.data,
    );
  }

  @override
  String toString() =>
      'PayInsteadLoadedState(data: $data ,metaModel:$metaModel)';
}

class PayInsteadsEmptyState extends PayInsteadsState {
  const PayInsteadsEmptyState();
  @override
  List<Object> get props => [];
}

class PayInsteadsErrorState extends PayInsteadsState {
  final Failure failure;
  const PayInsteadsErrorState({required this.failure});
  @override
  List<Object> get props => [failure];
}
