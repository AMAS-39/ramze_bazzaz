part of 'container_expenses_bloc.dart';

abstract class ContainerExpensesState extends Equatable {
  bool get loadIsNot {
    return items.isEmpty && this is! ContainerExpensesLoadingState;
  }

  List<ContainerExpenseModel> get items {
    if (this is ContainerExpensesLoadedState) {
      return (this as ContainerExpensesLoadedState).data;
    }
    return <ContainerExpenseModel>[];
  }

  const ContainerExpensesState({this.metaModel = const MetaModel()});
  @override
  List<Object> get props => [];
  final MetaModel metaModel;

  @override
  String toString() => 'ContainerExpenseState(metaModel: $metaModel)';
}

class ContainerExpenseInitialState extends ContainerExpensesState {
  @override
  List<Object> get props => [];
}

class ContainerExpensesLoadingState extends ContainerExpensesState {
  @override
  List<Object> get props => [];
}

class ContainerExpensesLoadedState extends ContainerExpensesState {
  final List<ContainerExpenseModel> data;
  const ContainerExpensesLoadedState({
    required this.data,
    required super.metaModel,
  });
  @override
  List<Object> get props => [data, metaModel, randomInt];

  ContainerExpensesLoadedState copyWith(
      {List<ContainerExpenseModel>? data, MetaModel? metaModel}) {
    return ContainerExpensesLoadedState(
      metaModel: metaModel ?? this.metaModel,
      data: data ?? this.data,
    );
  }

  @override
  String toString() =>
      'ContainerExpenseLoadedState(data: $data ,metaModel:$metaModel)';
}

class ContainerExpensesEmptyState extends ContainerExpensesState {
  const ContainerExpensesEmptyState();
  @override
  List<Object> get props => [];
}

class ContainerExpensesErrorState extends ContainerExpensesState {
  final Failure failure;
  const ContainerExpensesErrorState({required this.failure});
  @override
  List<Object> get props => [failure];
}
