part of 'containers_bloc.dart';

abstract class ContainersState extends Equatable {
  bool get loadIsNot {
    return items.isEmpty && this is! ContainersLoadingState;
  }

  List<ContainerModel> get items {
    if (this is ContainersLoadedState) {
      return (this as ContainersLoadedState).data;
    }
    return <ContainerModel>[];
  }

  const ContainersState({this.metaModel = const MetaModel()});
  @override
  List<Object> get props => [];
  final MetaModel metaModel;

  @override
  String toString() => 'ContainerState(metaModel: $metaModel)';
}

class ContainerInitialState extends ContainersState {
  @override
  List<Object> get props => [];
}

class ContainersLoadingState extends ContainersState {
  @override
  List<Object> get props => [];
}

class ContainersLoadedState extends ContainersState {
  final List<ContainerModel> data;
  const ContainersLoadedState({
    required this.data,
    required super.metaModel,
  });
  @override
  List<Object> get props => [data, metaModel, randomInt];

  ContainersLoadedState copyWith(
      {List<ContainerModel>? data, MetaModel? metaModel}) {
    return ContainersLoadedState(
      metaModel: metaModel ?? this.metaModel,
      data: data ?? this.data,
    );
  }

  @override
  String toString() =>
      'ContainerLoadedState(data: $data ,metaModel:$metaModel)';
}

class ContainersEmptyState extends ContainersState {
  const ContainersEmptyState();
  @override
  List<Object> get props => [];
}

class ContainersErrorState extends ContainersState {
  final Failure failure;
  const ContainersErrorState({required this.failure});
  @override
  List<Object> get props => [failure];
}
