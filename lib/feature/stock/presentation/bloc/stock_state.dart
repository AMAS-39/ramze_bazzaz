part of 'stock_bloc.dart';

enum StockStatus { initial, loading, loaded, error }

class StockState extends Equatable {
  const StockState({
    this.status = StockStatus.initial,
    this.stock = const [],
    this.searchQuery = '',
    this.startDate,
    this.endDate,
    this.errorMessage,
  });

  final StockStatus status;
  final List<StockItemModel> stock;
  final String searchQuery;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? errorMessage;

  StockState copyWith({
    StockStatus? status,
    List<StockItemModel>? stock,
    String? searchQuery,
    DateTime? startDate,
    DateTime? endDate,
    String? errorMessage,
  }) {
    return StockState(
      status: status ?? this.status,
      stock: stock ?? this.stock,
      searchQuery: searchQuery ?? this.searchQuery,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, stock, searchQuery, startDate, endDate, errorMessage];
}
