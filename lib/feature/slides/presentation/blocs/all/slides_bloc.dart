import 'package:app/core/shared/imports.dart';
import 'package:app/feature/loading_more/bloc/loading_more_bloc.dart';
import 'package:app/feature/slides/data/models/create_slide_model.dart';
import 'package:app/feature/slides/data/models/slides_filter.dart';
import 'package:app/feature/slides/data/models/slides_model.dart';
import 'package:app/feature/slides/data/models/update_slide_model.dart';
import 'package:app/feature/slides/domain/usecases/create_slide_usecase.dart';
import 'package:app/feature/slides/domain/usecases/delete_slide_usecase.dart';
import 'package:app/feature/slides/domain/usecases/get_slides_usecase.dart';
import 'package:app/feature/slides/domain/usecases/update_slide_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'slides_event.dart';
part 'slides_state.dart';

class SlidesBloc extends Bloc<SlideEvent, SlidesState> {
  SlidesBloc() : super(SlideInitialState()) {
    on<SlideLoadEvent>(_onLoadSlideEvent);
    on<SlideEmptyEvent>(_onSlideEmptyEvent);
    on<SlideDeleteEvent>(_onSlideDeleteEvent);
    on<SlideCreateEvent>(_onSlideCreateEvent);
    on<SlideUpdateEvent>(_onSlideUpdateEvent);
  }
  Future<void> _onSlideEmptyEvent(
      SlideEmptyEvent event, Emitter<SlidesState> emit) async {
    emit(SlideInitialState());
  }

  Future<void> _onSlideDeleteEvent(
      SlideDeleteEvent event, Emitter<SlidesState> emit) async {
    final isDeleted = await sl<DeleteSlideUsecase>().call(
        showMessage: ShowMessage.bothToast,
        showLoading: ShowLoading.show,
        model: event.model);
    if (isDeleted.isRight()) {
      emit(SlidesLoadedState(
          data: state.items
              .where((element) => element.id != event.model.id)
              .toList(),
          metaModel: state.metaModel));
    }
  }

  Future<void> _onSlideUpdateEvent(
      SlideUpdateEvent event, Emitter<SlidesState> emit) async {
    final result = await sl<UpdateSlideUsecase>().call(
        showMessage: ShowMessage.bothToast,
        showLoading: ShowLoading.show,
        model: event.model);
    if (result.isRight()) {
      final newData = state.items
          .map((element) => element.id != event.model.id
              ? element
              : result.getRight(() => null) != null
                  ? result.getRight(() => null)!
                  : element)
          .toList();
      emit(SlidesLoadedState(data: newData, metaModel: state.metaModel));
    }
  }

  Future<void> _onSlideCreateEvent(
      SlideCreateEvent event, Emitter<SlidesState> emit) async {
    final result = await sl<CreateSlideUsecase>().call(
        showMessage: ShowMessage.bothToast,
        showLoading: ShowLoading.show,
        model: event.model);
    if (result.isRight()) {
      emit(SlidesLoadedState(
          data: [...state.items, result.getRight(() => null)!],
          metaModel: state.metaModel));
    }
  }

  Future<void> _onLoadSlideEvent(
      SlideLoadEvent event, Emitter<SlidesState> eimter) async {
    if (state.loadIsNot || event.empty) {
      eimter(SlidesLoadingState());
    }
    final result = await sl<GetSlidesUsecase>().call(
        metaModel: state.metaModel
            .copyWith(page: currentPage(event.refresh, state.metaModel)),
        params: event.filters,
        showMessage: event.showMessage,
        dataSource: event.dataSource);
    result.fold(
      (failure) {
        if (state is! SlidesLoadedState) {
          eimter(SlidesErrorState(failure: failure));
        }
        event.onDone?.call(LoadingMoreEvent(
            status: LoadingMoreStatus(
                failure: failure, pagination: Pagination.error)));
      },
      (data) {
        event.onDone?.call(const LoadingMoreEvent(
            status: LoadingMoreStatus(pagination: Pagination.notMatch)));
        eimter(_mapPropsToState(
            data, currentPage(event.refresh, state.metaModel)));
      },
    );
    logger(state);
  }

  SlidesState _mapPropsToState(ReponseList<SlideModel>? data, int page) {
    if (data == null) {
      return state;
    }
    return data.data.isEmpty && state is! SlidesLoadedState
        ? const SlidesEmptyState()
        : SlidesLoadedState(
            metaModel: compineMeta(state.metaModel, data.meta),
            data: [if (page != firstPage) ...state.items, ...data.data]);
  }
}
