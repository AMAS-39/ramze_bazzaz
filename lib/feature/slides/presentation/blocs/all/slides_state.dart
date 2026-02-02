part of 'slides_bloc.dart';

abstract class SlidesState extends Equatable {
  bool get loadIsNot {
    return items.isEmpty && this is! SlidesLoadingState;
  }

  List<SlideModel> get items {
    if (this is SlidesLoadedState) {
      return (this as SlidesLoadedState).data;
    }
    return <SlideModel>[];
  }

  const SlidesState({this.metaModel = const MetaModel()});
  @override
  List<Object> get props => [];
  final MetaModel metaModel;

  @override
  String toString() => 'SlideState(metaModel: $metaModel)';
}

class SlideInitialState extends SlidesState {
  @override
  List<Object> get props => [];
}

class SlidesLoadingState extends SlidesState {
  @override
  List<Object> get props => [];
}

class SlidesLoadedState extends SlidesState {
  final List<SlideModel> data;
  const SlidesLoadedState({
    required this.data,
    required super.metaModel,
  });
  @override
  List<Object> get props => [data, metaModel];

  SlidesLoadedState copyWith({List<SlideModel>? data, MetaModel? metaModel}) {
    return SlidesLoadedState(
      metaModel: metaModel ?? this.metaModel,
      data: data ?? this.data,
    );
  }

  @override
  String toString() => 'SlideLoadedState(data: $data ,metaModel:$metaModel)';
}

class SlidesEmptyState extends SlidesState {
  const SlidesEmptyState();
  @override
  List<Object> get props => [];
}

class SlidesErrorState extends SlidesState {
  final Failure failure;
  const SlidesErrorState({required this.failure});
  @override
  List<Object> get props => [failure];
}
