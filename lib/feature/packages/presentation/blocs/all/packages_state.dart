part of 'packages_bloc.dart';

abstract class PackagesState extends Equatable {
  bool get loadIsNot {
    return items.isEmpty && this is! PackagesLoadingState;
  }

  List<PackageModel> get items {
    if (this is PackagesLoadedState) {
      return (this as PackagesLoadedState).data;
    }
    return <PackageModel>[];
  }

  const PackagesState({this.metaModel = const MetaModel()});
  @override
  List<Object> get props => [];
  final MetaModel metaModel;

  @override
  String toString() => 'PackageState(metaModel: $metaModel)';
}

class PackageInitialState extends PackagesState {
  @override
  List<Object> get props => [];
}

class PackagesLoadingState extends PackagesState {
  @override
  List<Object> get props => [];
}

class PackagesLoadedState extends PackagesState {
  final List<PackageModel> data;
  const PackagesLoadedState({
    required this.data,
    required super.metaModel,
  });
  @override
  List<Object> get props => [data, metaModel, randomInt];

  PackagesLoadedState copyWith(
      {List<PackageModel>? data, MetaModel? metaModel}) {
    return PackagesLoadedState(
      metaModel: metaModel ?? this.metaModel,
      data: data ?? this.data,
    );
  }

  @override
  String toString() => 'PackageLoadedState(data: $data ,metaModel:$metaModel)';
}

class PackagesEmptyState extends PackagesState {
  const PackagesEmptyState();
  @override
  List<Object> get props => [];
}

class PackagesErrorState extends PackagesState {
  final Failure failure;
  const PackagesErrorState({required this.failure});
  @override
  List<Object> get props => [failure];
}
