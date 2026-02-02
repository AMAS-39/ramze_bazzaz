part of 'loading_more_bloc.dart';

class LoadingMoreEvent extends Equatable {
  final LoadingMoreStatus status;
  const LoadingMoreEvent({
    required this.status,
  });

  @override
  List<Object?> get props => [status, DateTime.now()];
}
