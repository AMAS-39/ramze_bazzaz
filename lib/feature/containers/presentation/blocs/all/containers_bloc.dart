import 'package:app/core/shared/imports.dart';
import 'package:app/feature/containers/data/models/containers_filter.dart';
import 'package:app/feature/containers/data/models/containers_model.dart';
import 'package:app/feature/containers/data/models/create_container_model.dart';
import 'package:app/feature/containers/data/models/update_container_model.dart';
import 'package:app/feature/containers/domain/usecases/create_container_usecase.dart';
import 'package:app/feature/containers/domain/usecases/delete_container_usecase.dart';
import 'package:app/feature/containers/domain/usecases/get_containers_usecase.dart';
import 'package:app/feature/containers/domain/usecases/update_container_usecase.dart';
import 'package:app/feature/loading_more/bloc/loading_more_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'containers_event.dart';
part 'containers_state.dart';

class ContainersBloc extends Bloc<ContainerEvent, ContainersState> {
  ContainersBloc() : super(ContainerInitialState()) {
    on<ContainerLoadEvent>(_onLoadContainerEvent);
    on<ContainerEmptyEvent>(_onContainerEmptyEvent);
    on<ContainerDeleteEvent>(_onContainerDeleteEvent);
    on<ContainerCreateEvent>(_onContainerCreateEvent);
    on<ContainerUpdateEvent>(_onContainerUpdateEvent);
  }
  Future<void> _onContainerEmptyEvent(
      ContainerEmptyEvent event, Emitter<ContainersState> emit) async {
    emit(ContainerInitialState());
  }

  Future<void> _onContainerDeleteEvent(
      ContainerDeleteEvent event, Emitter<ContainersState> emit) async {
    final isDeleted = await sl<DeleteContainerUsecase>().call(
        showMessage: ShowMessage.bothToast,
        showLoading: ShowLoading.show,
        model: event.model);
    if (isDeleted.isRight()) {
      emit(ContainersLoadedState(
          data: state.items
              .where((element) => element.id != event.model.id)
              .toList(),
          metaModel: state.metaModel));
    }
  }

  Future<void> _onContainerUpdateEvent(
      ContainerUpdateEvent event, Emitter<ContainersState> emit) async {
    final result = await sl<UpdateContainerUsecase>().call(
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
      emit(ContainersLoadedState(data: newData, metaModel: state.metaModel));
    }
  }

  Future<void> _onContainerCreateEvent(
      ContainerCreateEvent event, Emitter<ContainersState> emit) async {
    final result = await sl<CreateContainerUsecase>().call(
        showMessage: ShowMessage.bothToast,
        showLoading: ShowLoading.show,
        model: event.model);
    if (result.isRight()) {
      emit(ContainersLoadedState(
          data: [...state.items, result.getRight(() => null)!],
          metaModel: state.metaModel));
    }
  }

  Future<void> _onLoadContainerEvent(
      ContainerLoadEvent event, Emitter<ContainersState> eimter) async {
    if (state.loadIsNot || event.empty) {
      eimter(ContainersLoadingState());
    }
    final result = await sl<GetContainersUsecase>().call(
        metaModel: state.metaModel
            .copyWith(page: currentPage(event.refresh, state.metaModel)),
        params: event.filters,
        showMessage: event.showMessage,
        dataSource: event.dataSource);
    result.fold(
      (failure) {
        if (state is! ContainersLoadedState) {
          eimter(ContainersErrorState(failure: failure));
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

  ContainersState _mapPropsToState(
      ReponseList<ContainerModel>? data, int page) {
    if (data == null) {
      return state;
    }
    return data.data.isEmpty && state is! ContainersLoadedState
        ? const ContainersEmptyState()
        : ContainersLoadedState(
            metaModel: compineMeta(state.metaModel, data.meta),
            data: [if (page != firstPage) ...state.items, ...data.data]);
  }
}
