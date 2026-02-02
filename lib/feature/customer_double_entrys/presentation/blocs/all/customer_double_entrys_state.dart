part of 'customer_double_entrys_bloc.dart';

abstract class CustomerDoubleEntrysState extends Equatable {
  bool get loadIsNot {
    return items.isEmpty && this is! CustomerDoubleEntrysLoadingState;
  }

  List<CustomerDoubleEntryModel> get items {
    if (this is CustomerDoubleEntrysLoadedState) {
      return (this as CustomerDoubleEntrysLoadedState).data;
    }
    return <CustomerDoubleEntryModel>[];
  }

  const CustomerDoubleEntrysState({this.metaModel = const MetaModel()});
  @override
  List<Object> get props => [];
  final MetaModel metaModel;

  @override
  String toString() => 'CustomerDoubleEntryState(metaModel: $metaModel)';
}

class CustomerDoubleEntryInitialState extends CustomerDoubleEntrysState {
  @override
  List<Object> get props => [];
}

class CustomerDoubleEntrysLoadingState extends CustomerDoubleEntrysState {
  @override
  List<Object> get props => [];
}

class CustomerDoubleEntrysLoadedState extends CustomerDoubleEntrysState {
  final List<CustomerDoubleEntryModel> data;
  const CustomerDoubleEntrysLoadedState({
    required this.data,
    required super.metaModel,
  });
  @override
  List<Object> get props => [data, metaModel, randomInt];

  CustomerDoubleEntrysLoadedState copyWith(
      {List<CustomerDoubleEntryModel>? data, MetaModel? metaModel}) {
    return CustomerDoubleEntrysLoadedState(
      metaModel: metaModel ?? this.metaModel,
      data: data ?? this.data,
    );
  }

  @override
  String toString() =>
      'CustomerDoubleEntryLoadedState(data: $data ,metaModel:$metaModel)';
}

class CustomerDoubleEntrysEmptyState extends CustomerDoubleEntrysState {
  const CustomerDoubleEntrysEmptyState();
  @override
  List<Object> get props => [];
}

class CustomerDoubleEntrysErrorState extends CustomerDoubleEntrysState {
  final Failure failure;
  const CustomerDoubleEntrysErrorState({required this.failure});
  @override
  List<Object> get props => [failure];
}
