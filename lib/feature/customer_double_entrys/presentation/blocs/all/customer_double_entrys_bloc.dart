import 'package:app/core/shared/imports.dart';
import 'package:app/feature/customer_double_entrys/data/models/create_customer_double_entry_model.dart';
import 'package:app/feature/customer_double_entrys/data/models/customer_double_entrys_filter.dart';
import 'package:app/feature/customer_double_entrys/data/models/customer_double_entrys_model.dart';
import 'package:app/feature/customer_double_entrys/data/models/update_customer_double_entry_model.dart';
import 'package:app/feature/customer_double_entrys/domain/usecases/create_customer_double_entry_usecase.dart';
import 'package:app/feature/customer_double_entrys/domain/usecases/delete_customer_double_entry_usecase.dart';
import 'package:app/feature/customer_double_entrys/domain/usecases/get_customer_double_entrys_usecase.dart';
import 'package:app/feature/customer_double_entrys/domain/usecases/update_customer_double_entry_usecase.dart';
import 'package:app/feature/loading_more/bloc/loading_more_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'customer_double_entrys_event.dart';
part 'customer_double_entrys_state.dart';

class CustomerDoubleEntrysBloc
    extends Bloc<CustomerDoubleEntryEvent, CustomerDoubleEntrysState> {
  CustomerDoubleEntrysBloc() : super(CustomerDoubleEntryInitialState()) {
    on<CustomerDoubleEntryLoadEvent>(_onLoadCustomerDoubleEntryEvent);
    on<CustomerDoubleEntryEmptyEvent>(_onCustomerDoubleEntryEmptyEvent);
    on<CustomerDoubleEntryDeleteEvent>(_onCustomerDoubleEntryDeleteEvent);
    on<CustomerDoubleEntryCreateEvent>(_onCustomerDoubleEntryCreateEvent);
    on<CustomerDoubleEntryUpdateEvent>(_onCustomerDoubleEntryUpdateEvent);
  }
  Future<void> _onCustomerDoubleEntryEmptyEvent(CustomerDoubleEntryEmptyEvent event,
      Emitter<CustomerDoubleEntrysState> emit) async {
    emit(CustomerDoubleEntryInitialState());
  }

  Future<void> _onCustomerDoubleEntryDeleteEvent(CustomerDoubleEntryDeleteEvent event,
      Emitter<CustomerDoubleEntrysState> emit) async {
    final isDeleted = await sl<DeleteCustomerDoubleEntryUsecase>().call(
        showMessage: ShowMessage.bothToast,
        showLoading: ShowLoading.show,
        model: event.model);
    if (isDeleted.isRight()) {
      emit(CustomerDoubleEntrysLoadedState(
          data: state.items
              .where((element) => element.id != event.model.id)
              .toList(),
          metaModel: state.metaModel));
    }
  }

  Future<void> _onCustomerDoubleEntryUpdateEvent(CustomerDoubleEntryUpdateEvent event,
      Emitter<CustomerDoubleEntrysState> emit) async {
    final result = await sl<UpdateCustomerDoubleEntryUsecase>().call(
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
      emit(CustomerDoubleEntrysLoadedState(
          data: newData, metaModel: state.metaModel));
    }
  }

  Future<void> _onCustomerDoubleEntryCreateEvent(CustomerDoubleEntryCreateEvent event,
      Emitter<CustomerDoubleEntrysState> emit) async {
    final result = await sl<CreateCustomerDoubleEntryUsecase>().call(
        showMessage: ShowMessage.bothToast,
        showLoading: ShowLoading.show,
        model: event.model);
    if (result.isRight()) {
      emit(CustomerDoubleEntrysLoadedState(
          data: [...state.items, result.getRight(() => null)!],
          metaModel: state.metaModel));
    }
  }

  Future<void> _onLoadCustomerDoubleEntryEvent(CustomerDoubleEntryLoadEvent event,
      Emitter<CustomerDoubleEntrysState> eimter) async {
    if (state.loadIsNot || event.empty) {
      eimter(CustomerDoubleEntrysLoadingState());
    }
    final result = await sl<GetCustomerDoubleEntrysUsecase>().call(
        metaModel: state.metaModel
            .copyWith(page: currentPage(event.refresh, state.metaModel)),
        params: event.filters,
        showMessage: event.showMessage,
        dataSource: event.dataSource);
    result.fold(
      (failure) {
        if (state is! CustomerDoubleEntrysLoadedState) {
          eimter(CustomerDoubleEntrysErrorState(failure: failure));
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

  CustomerDoubleEntrysState _mapPropsToState(
      ReponseList<CustomerDoubleEntryModel>? data, int page) {
    if (data == null) {
      return state;
    }
    return data.data.isEmpty && state is! CustomerDoubleEntrysLoadedState
        ? const CustomerDoubleEntrysEmptyState()
        : CustomerDoubleEntrysLoadedState(
            metaModel: compineMeta(state.metaModel, data.meta),
            data: [if (page != firstPage) ...state.items, ...data.data]);
  }
}
