import 'package:app/core/shared/imports.dart';
import 'package:app/feature/containers/data/models/container_details_model.dart';
import 'package:app/feature/containers/domain/usecases/get_container_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'container_event.dart';
part 'container_state.dart';

class OneContainerBloc extends Bloc<OneContainerEvent, OneContainerState> {
  OneContainerBloc() : super(OneContainerInitialState()) {
    on<OneContainerGetEvent>(oneContainerGetEvent);
    on<OneContainerReinitEvent>(oneContainerReinitEvent);
  }
  Future<void> oneContainerReinitEvent(
      OneContainerReinitEvent event, Emitter<OneContainerState> emiter) async {
    emiter(OneContainerInitialState());
  }

  Future<Either<Failure, ContainerDetailsModel?>> oneContainerGetEvent(
      OneContainerGetEvent event, Emitter<OneContainerState> emiter) async {
    emiter(OneContainerLoadingState());

    final result = await sl<GetContainerUsecase>().call(
        params: {},
        id: event.id,
        showMessage: event.showMessage,
        dataSource: event.dataSource);
    logger(result);
    result.fold((failure) {
      if (state is! OneContainerLoadedState) {
        emiter(OneContainerErrorState(failure: failure));
      } else if (state is OneContainerLoadedState) {
        emiter(OneContainerLoadedState(
            data: (state as OneContainerLoadedState).data,
            failure: failure
              ..error.copyWith(message: Trans.canotRefreshPage.trans())));
      }
    }, (data) => emiter(_mapPropsToState(data)));
    logger("state $state");
    return result;
  }

  OneContainerState _mapPropsToState(ContainerDetailsModel? container) {
    return container == null
        ? const OneContainerEmptyState()
        : OneContainerLoadedState(failure: null, data: container);
  }
}
