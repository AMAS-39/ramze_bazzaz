part of 'container_expense_bloc.dart';

abstract class OneContainerExpenseState extends Equatable {
  const OneContainerExpenseState();
  @override
  List<Object?> get props => [];
}

class OneContainerExpenseInitialState extends OneContainerExpenseState {
  @override
  List<Object?> get props => [];
}

class OneContainerExpenseLoadingState extends OneContainerExpenseState {
  @override
  List<Object?> get props => [];
}

class OneContainerExpenseLoadedState extends OneContainerExpenseState {
  final ContainerExpenseDetailsModel data;
  const OneContainerExpenseLoadedState({this.failure, required this.data});
  final Failure? failure;
  @override
  List<Object?> get props => [data, failure, DateTime.now()];
}

class OneContainerExpenseEmptyState extends OneContainerExpenseState {
  const OneContainerExpenseEmptyState();

  @override
  List<Object> get props => [];
}

class OneContainerExpenseErrorState extends OneContainerExpenseState {
  final Failure failure;
  const OneContainerExpenseErrorState({required this.failure});
  @override
  List<Object> get props => [failure];
}
