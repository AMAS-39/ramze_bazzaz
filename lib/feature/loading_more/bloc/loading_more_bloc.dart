import 'package:app/core/shared/imports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'loading_more_event.dart';
part 'loading_more_state.dart';

class LoadMoreBloc extends Bloc<LoadingMoreEvent, LoadingMoreStatus> {
  LoadMoreBloc()
      : super(const LoadingMoreStatus(
            failure: null, pagination: Pagination.notMatch)) {
    on<LoadingMoreEvent>(onEvents);
  }
  void onEvents(LoadingMoreEvent event, Emitter<LoadingMoreStatus> emit) {
    emit(state.copyWith(
        failure: event.status.failure, pagination: event.status.pagination));
    logger("state $state");
  }
}
