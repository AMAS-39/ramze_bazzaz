import 'package:app/core/error/failure_message_model.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({required this.error});
  final FailureMessage error;
}

class ServerFailure extends Failure {
  const ServerFailure({required super.error});
  @override
  List<Object?> get props => [error];
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.error});

  @override
  List<Object?> get props => [FailureMessage];
}

class UnAuthFailure extends Failure {
  const UnAuthFailure({required super.error});

  @override
  List<Object?> get props => [error];
}

class ErrorFailure extends Failure {
  const ErrorFailure({required super.error});

  @override
  List<Object?> get props => [error];
}

class EmptyData extends Failure {
  const EmptyData({required super.error});

  @override
  List<Object?> get props => [error];
}
