part of 'package_bloc.dart';

abstract class OnePackageState extends Equatable {
  const OnePackageState();
  @override
  List<Object?> get props => [];
}

class OnePackageInitialState extends OnePackageState {
  @override
  List<Object?> get props => [];
}

class OnePackageLoadingState extends OnePackageState {
  @override
  List<Object?> get props => [];
}

class OnePackageLoadedState extends OnePackageState {
  final PackageDetailsModel data;
  const OnePackageLoadedState({this.failure, required this.data});
  final Failure? failure;
  @override
  List<Object?> get props => [data, failure, DateTime.now()];
}

class OnePackageEmptyState extends OnePackageState {
  const OnePackageEmptyState();

  @override
  List<Object> get props => [];
}

class OnePackageErrorState extends OnePackageState {
  final Failure failure;
  const OnePackageErrorState({required this.failure});
  @override
  List<Object> get props => [failure];
}
