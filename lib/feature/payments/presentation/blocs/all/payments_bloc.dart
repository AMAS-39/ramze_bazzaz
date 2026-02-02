import 'package:app/core/shared/imports.dart';
import 'package:app/feature/loading_more/bloc/loading_more_bloc.dart';
import 'package:app/feature/payments/data/models/create_payment_model.dart';
import 'package:app/feature/payments/data/models/payments_filter.dart';
import 'package:app/feature/payments/data/models/payments_model.dart';
import 'package:app/feature/payments/data/models/update_payment_model.dart';
import 'package:app/feature/payments/domain/usecases/create_payment_usecase.dart';
import 'package:app/feature/payments/domain/usecases/delete_payment_usecase.dart';
import 'package:app/feature/payments/domain/usecases/get_payments_usecase.dart';
import 'package:app/feature/payments/domain/usecases/update_payment_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payments_event.dart';
part 'payments_state.dart';

class PaymentsBloc extends Bloc<PaymentEvent, PaymentsState> {
  PaymentsBloc() : super(PaymentInitialState()) {
    on<PaymentLoadEvent>(_onLoadPaymentEvent);
    on<PaymentEmptyEvent>(_onPaymentEmptyEvent);
    on<PaymentDeleteEvent>(_onPaymentDeleteEvent);
    on<PaymentCreateEvent>(_onPaymentCreateEvent);
    on<PaymentUpdateEvent>(_onPaymentUpdateEvent);
  }
  Future<void> _onPaymentEmptyEvent(
      PaymentEmptyEvent event, Emitter<PaymentsState> emit) async {
    emit(PaymentInitialState());
  }

  Future<void> _onPaymentDeleteEvent(
      PaymentDeleteEvent event, Emitter<PaymentsState> emit) async {
    final isDeleted = await sl<DeletePaymentUsecase>().call(
        showMessage: ShowMessage.bothToast,
        showLoading: ShowLoading.show,
        model: event.model);
    if (isDeleted.isRight()) {
      emit(PaymentsLoadedState(
          data: state.items
              .where((element) => element.id != event.model.id)
              .toList(),
          metaModel: state.metaModel));
    }
  }

  Future<void> _onPaymentUpdateEvent(
      PaymentUpdateEvent event, Emitter<PaymentsState> emit) async {
    final result = await sl<UpdatePaymentUsecase>().call(
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
      emit(PaymentsLoadedState(data: newData, metaModel: state.metaModel));
    }
  }

  Future<void> _onPaymentCreateEvent(
      PaymentCreateEvent event, Emitter<PaymentsState> emit) async {
    final result = await sl<CreatePaymentUsecase>().call(
        showMessage: ShowMessage.bothToast,
        showLoading: ShowLoading.show,
        model: event.model);
    if (result.isRight()) {
      emit(PaymentsLoadedState(
          data: [...state.items, result.getRight(() => null)!],
          metaModel: state.metaModel));
    }
  }

  Future<void> _onLoadPaymentEvent(
      PaymentLoadEvent event, Emitter<PaymentsState> eimter) async {
    if (state.loadIsNot || event.empty) {
      eimter(PaymentsLoadingState());
    }
    final result = await sl<GetPaymentsUsecase>().call(
        metaModel: state.metaModel
            .copyWith(page: currentPage(event.refresh, state.metaModel)),
        params: event.filters,
        showMessage: event.showMessage,
        dataSource: event.dataSource);
    result.fold(
      (failure) {
        if (state is! PaymentsLoadedState) {
          eimter(PaymentsErrorState(failure: failure));
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

  PaymentsState _mapPropsToState(ReponseList<PaymentModel>? data, int page) {
    if (data == null) {
      return state;
    }
    return data.data.isEmpty && state is! PaymentsLoadedState
        ? const PaymentsEmptyState()
        : PaymentsLoadedState(
            metaModel: compineMeta(state.metaModel, data.meta),
            data: [if (page != firstPage) ...state.items, ...data.data]);
  }
}
