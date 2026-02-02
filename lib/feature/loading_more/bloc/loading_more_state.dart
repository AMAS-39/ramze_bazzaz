part of 'loading_more_bloc.dart';

class LoadingMoreStatus extends Equatable {
  const LoadingMoreStatus({this.failure, required this.pagination});
  final Failure? failure;
  final Pagination pagination;
  @override
  List<Object?> get props => [pagination, failure, DateTime.now()];

  LoadingMoreStatus copyWith({
    Failure? failure,
    Pagination? pagination,
  }) {
    return LoadingMoreStatus(
      failure: failure ?? this.failure,
      pagination: pagination ?? this.pagination,
    );
  }
}
