import 'package:app/core/shared/imports.dart';
import 'package:app/feature/loading_more/bloc/loading_more_bloc.dart';
import 'package:app/feature/pay_insteads/data/models/create_pay_instead_model.dart';
import 'package:app/feature/pay_insteads/data/models/pay_insteads_filter.dart';
import 'package:app/feature/pay_insteads/data/models/pay_insteads_model.dart';
import 'package:app/feature/pay_insteads/data/models/update_pay_instead_model.dart';
import 'package:app/feature/pay_insteads/domain/usecases/create_pay_instead_usecase.dart';
import 'package:app/feature/pay_insteads/domain/usecases/delete_pay_instead_usecase.dart';
import 'package:app/feature/pay_insteads/domain/usecases/get_pay_insteads_usecase.dart';
import 'package:app/feature/pay_insteads/domain/usecases/update_pay_instead_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pay_insteads_event.dart';
part 'pay_insteads_state.dart';

class PayInsteadsBloc extends Bloc<PayInsteadEvent, PayInsteadsState> {
  PayInsteadsBloc() : super(PayInsteadInitialState()) {
    on<PayInsteadLoadEvent>(_onLoadPayInsteadEvent);
    on<PayInsteadEmptyEvent>(_onPayInsteadEmptyEvent);
    on<PayInsteadDeleteEvent>(_onPayInsteadDeleteEvent);
    on<PayInsteadCreateEvent>(_onPayInsteadCreateEvent);
    on<PayInsteadUpdateEvent>(_onPayInsteadUpdateEvent);
  }
  Future<void> _onPayInsteadEmptyEvent(
      PayInsteadEmptyEvent event, Emitter<PayInsteadsState> emit) async {
    emit(PayInsteadInitialState());
  }

  Future<void> _onPayInsteadDeleteEvent(
      PayInsteadDeleteEvent event, Emitter<PayInsteadsState> emit) async {
    final isDeleted = await sl<DeletePayInsteadUsecase>().call(
        showMessage: ShowMessage.bothToast,
        showLoading: ShowLoading.show,
        model: event.model);
    if (isDeleted.isRight()) {
      emit(PayInsteadsLoadedState(
          data: state.items
              .where((element) => element.id != event.model.id)
              .toList(),
          metaModel: state.metaModel));
    }
  }

  Future<void> _onPayInsteadUpdateEvent(
      PayInsteadUpdateEvent event, Emitter<PayInsteadsState> emit) async {
    final result = await sl<UpdatePayInsteadUsecase>().call(
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
      emit(PayInsteadsLoadedState(data: newData, metaModel: state.metaModel));
    }
  }

  Future<void> _onPayInsteadCreateEvent(
      PayInsteadCreateEvent event, Emitter<PayInsteadsState> emit) async {
    final result = await sl<CreatePayInsteadUsecase>().call(
        showMessage: ShowMessage.bothToast,
        showLoading: ShowLoading.show,
        model: event.model);
    if (result.isRight()) {
      emit(PayInsteadsLoadedState(
          data: [...state.items, result.getRight(() => null)!],
          metaModel: state.metaModel));
    }
  }

  Future<void> _onLoadPayInsteadEvent(
      PayInsteadLoadEvent event, Emitter<PayInsteadsState> eimter) async {
    if (state.loadIsNot || event.empty) {
      eimter(PayInsteadsLoadingState());
    }
    final result = await sl<GetPayInsteadsUsecase>().call(
        metaModel: state.metaModel
            .copyWith(page: currentPage(event.refresh, state.metaModel)),
        params: event.filters,
        showMessage: event.showMessage,
        dataSource: event.dataSource);
    result.fold(
      (failure) {
        if (state is! PayInsteadsLoadedState) {
          eimter(PayInsteadsErrorState(failure: failure));
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

  PayInsteadsState _mapPropsToState(
      ReponseList<PayInsteadModel>? data, int page) {
    if (data == null) {
      return state;
    }
    return data.data.isEmpty && state is! PayInsteadsLoadedState
        ? const PayInsteadsEmptyState()
        : PayInsteadsLoadedState(
            metaModel: compineMeta(state.metaModel, data.meta),
            data: [if (page != firstPage) ...state.items, ...data.data]);
  }
}

class PayReturnBloc extends PayInsteadsBloc {}
