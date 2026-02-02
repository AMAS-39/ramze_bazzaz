import 'package:app/core/shared/imports.dart';
import 'package:app/feature/slides/data/models/slide_details_model.dart';
import 'package:app/feature/slides/domain/usecases/get_slide_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'slide_event.dart';
part 'slide_state.dart';

class OneSlideBloc extends Bloc<OneSlideEvent, OneSlideState> {
  OneSlideBloc() : super(OneSlideInitialState()) {
    on<OneSlideGetEvent>(oneSlideGetEvent);
  }
  Future<Either<Failure, SlideDetailsModel?>> oneSlideGetEvent(
      OneSlideGetEvent event, Emitter<OneSlideState> emiter) async {
    emiter(OneSlideLoadingState());

    final result = await sl<GetSlideUsecase>().call(
        params: {},
        id: event.id,
        showMessage: event.showMessage,
        dataSource: event.dataSource);
    logger(result);
    result.fold((failure) {
      if (state is! OneSlideLoadedState) {
        emiter(OneSlideErrorState(failure: failure));
      } else if (state is OneSlideLoadedState) {
        emiter(OneSlideLoadedState(
            data: (state as OneSlideLoadedState).data,
            failure: failure
              ..error.copyWith(message: Trans.canotRefreshPage.trans())));
      }
    }, (data) => emiter(_mapPropsToState(data)));
    logger("state $state");
    return result;
  }

  OneSlideState _mapPropsToState(SlideDetailsModel? slide) {
    return slide == null
        ? const OneSlideEmptyState()
        : OneSlideLoadedState(failure: null, data: slide);
  }
}
