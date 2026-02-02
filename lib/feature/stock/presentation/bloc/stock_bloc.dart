import 'package:app/core/shared/imports.dart';
import 'package:app/feature/stock/data/models/stock_item_model.dart';
import 'package:app/feature/stock/domain/repositories/stock_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'stock_event.dart';
part 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  StockBloc({required this.repository}) : super(const StockState()) {
    on<StockLoadEvent>(_onLoad);
    on<StockSearchEvent>(_onSearch);
    on<StockSetDateRangeEvent>(_onSetDateRange);
    on<StockClearSearchEvent>(_onClearSearch);
  }

  final StockRepositoryAbs repository;

  Future<void> _onLoad(StockLoadEvent event, Emitter<StockState> emit) async {
    if (!event.silent) emit(state.copyWith(status: StockStatus.loading));
    final result = await repository.fetchStock(
      search: state.searchQuery.isEmpty ? null : state.searchQuery,
      startDate: state.startDate,
      endDate: state.endDate,
      showLoading: event.silent ? ShowLoading.none : ShowLoading.show,
      showMessage: ShowMessage.none,
    );
    result.fold(
      (failure) => emit(state.copyWith(
        status: StockStatus.error,
        errorMessage: failure.error.reason,
      )),
      (list) => emit(state.copyWith(
        status: StockStatus.loaded,
        stock: list,
        errorMessage: null,
      )),
    );
  }

  Future<void> _onSearch(StockSearchEvent event, Emitter<StockState> emit) async {
    emit(state.copyWith(searchQuery: event.query));
    add(const StockLoadEvent(silent: false));
  }

  Future<void> _onSetDateRange(StockSetDateRangeEvent event, Emitter<StockState> emit) async {
    emit(state.copyWith(startDate: event.start, endDate: event.end));
    add(const StockLoadEvent(silent: false));
  }

  Future<void> _onClearSearch(StockClearSearchEvent event, Emitter<StockState> emit) async {
    emit(state.copyWith(
      searchQuery: '',
      startDate: null,
      endDate: null,
    ));
    add(const StockLoadEvent(silent: false));
  }
}
