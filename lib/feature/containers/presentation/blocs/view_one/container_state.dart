part of 'container_bloc.dart';

abstract class OneContainerState extends Equatable {
  const OneContainerState();
  @override
  List<Object?> get props => [];
}

class OneContainerInitialState extends OneContainerState {
  @override
  List<Object?> get props => [];
}

class OneContainerLoadingState extends OneContainerState {
  @override
  List<Object?> get props => [];
}

class OneContainerLoadedState extends OneContainerState {
  final ContainerDetailsModel data;
  const OneContainerLoadedState({this.failure, required this.data});
  final Failure? failure;
  @override
  List<Object?> get props => [data, failure, DateTime.now()];
}

class OneContainerEmptyState extends OneContainerState {
  const OneContainerEmptyState();

  @override
  List<Object> get props => [];
}

class OneContainerErrorState extends OneContainerState {
  final Failure failure;
  const OneContainerErrorState({required this.failure});
  @override
  List<Object> get props => [failure];
}
