import 'package:app/core/shared/imports.dart';
import 'package:app/feature/container_expenses/data/models/container_expenses_filter.dart';
import 'package:app/feature/container_expenses/data/models/container_expenses_model.dart';
import 'package:app/feature/container_expenses/data/models/create_container_expense_model.dart';
import 'package:app/feature/container_expenses/data/models/update_container_expense_model.dart';
import 'package:app/feature/container_expenses/domain/usecases/create_container_expense_usecase.dart';
import 'package:app/feature/container_expenses/domain/usecases/delete_container_expense_usecase.dart';
import 'package:app/feature/container_expenses/domain/usecases/get_container_expenses_usecase.dart';
import 'package:app/feature/container_expenses/domain/usecases/update_container_expense_usecase.dart';
import 'package:app/feature/loading_more/bloc/loading_more_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'container_expenses_event.dart';
part 'container_expenses_state.dart';

class ContainerExpensesBloc
    extends Bloc<ContainerExpenseEvent, ContainerExpensesState> {
  ContainerExpensesBloc() : super(ContainerExpenseInitialState()) {
    on<ContainerExpenseLoadEvent>(_onLoadContainerExpenseEvent);
    on<ContainerExpenseEmptyEvent>(_onContainerExpenseEmptyEvent);
    on<ContainerExpenseDeleteEvent>(_onContainerExpenseDeleteEvent);
    on<ContainerExpenseCreateEvent>(_onContainerExpenseCreateEvent);
    on<ContainerExpenseUpdateEvent>(_onContainerExpenseUpdateEvent);
  }
  Future<void> _onContainerExpenseEmptyEvent(ContainerExpenseEmptyEvent event,
      Emitter<ContainerExpensesState> emit) async {
    emit(ContainerExpenseInitialState());
  }

  Future<void> _onContainerExpenseDeleteEvent(ContainerExpenseDeleteEvent event,
      Emitter<ContainerExpensesState> emit) async {
    final isDeleted = await sl<DeleteContainerExpenseUsecase>().call(
        showMessage: ShowMessage.bothToast,
        showLoading: ShowLoading.show,
        model: event.model);
    if (isDeleted.isRight()) {
      emit(ContainerExpensesLoadedState(
          data: state.items
              .where((element) => element.id != event.model.id)
              .toList(),
          metaModel: state.metaModel));
    }
  }

  Future<void> _onContainerExpenseUpdateEvent(ContainerExpenseUpdateEvent event,
      Emitter<ContainerExpensesState> emit) async {
    final result = await sl<UpdateContainerExpenseUsecase>().call(
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
      emit(ContainerExpensesLoadedState(
          data: newData, metaModel: state.metaModel));
    }
  }

  Future<void> _onContainerExpenseCreateEvent(ContainerExpenseCreateEvent event,
      Emitter<ContainerExpensesState> emit) async {
    final result = await sl<CreateContainerExpenseUsecase>().call(
        showMessage: ShowMessage.bothToast,
        showLoading: ShowLoading.show,
        model: event.model);
    if (result.isRight()) {
      emit(ContainerExpensesLoadedState(
          data: [...state.items, result.getRight(() => null)!],
          metaModel: state.metaModel));
    }
  }

  Future<void> _onLoadContainerExpenseEvent(ContainerExpenseLoadEvent event,
      Emitter<ContainerExpensesState> eimter) async {
    if (state.loadIsNot || event.empty) {
      eimter(ContainerExpensesLoadingState());
    }
    final result = await sl<GetContainerExpensesUsecase>().call(
        metaModel: state.metaModel
            .copyWith(page: currentPage(event.refresh, state.metaModel)),
        params: event.filters,
        showMessage: event.showMessage,
        dataSource: event.dataSource);
    result.fold(
      (failure) {
        if (state is! ContainerExpensesLoadedState) {
          eimter(ContainerExpensesErrorState(failure: failure));
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

  ContainerExpensesState _mapPropsToState(
      ReponseList<ContainerExpenseModel>? data, int page) {
    if (data == null) {
      return state;
    }
    return data.data.isEmpty && state is! ContainerExpensesLoadedState
        ? const ContainerExpensesEmptyState()
        : ContainerExpensesLoadedState(
            metaModel: compineMeta(state.metaModel, data.meta),
            data: [if (page != firstPage) ...state.items, ...data.data]);
  }
}
