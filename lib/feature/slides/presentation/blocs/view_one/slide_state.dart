part of 'slide_bloc.dart';

abstract class OneSlideState extends Equatable {
  const OneSlideState();
  @override
  List<Object?> get props => [];
}

class OneSlideInitialState extends OneSlideState {
  @override
  List<Object?> get props => [];
}

class OneSlideLoadingState extends OneSlideState {
  @override
  List<Object?> get props => [];
}

class OneSlideLoadedState extends OneSlideState {
  final SlideDetailsModel data;
  const OneSlideLoadedState({this.failure, required this.data});
  final Failure? failure;
  @override
  List<Object?> get props => [data, failure, DateTime.now()];
}

class OneSlideEmptyState extends OneSlideState {
  const OneSlideEmptyState();

  @override
  List<Object> get props => [];
}

class OneSlideErrorState extends OneSlideState {
  final Failure failure;
  const OneSlideErrorState({required this.failure});
  @override
  List<Object> get props => [failure];
}
