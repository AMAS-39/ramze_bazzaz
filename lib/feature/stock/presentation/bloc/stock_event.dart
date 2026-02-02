part of 'stock_bloc.dart';

abstract class StockEvent extends Equatable {
  const StockEvent();
  @override
  List<Object?> get props => [];
}

class StockLoadEvent extends StockEvent {
  const StockLoadEvent({this.silent = false});
  final bool silent;
  @override
  List<Object?> get props => [silent];
}

class StockSearchEvent extends StockEvent {
  const StockSearchEvent(this.query);
  final String query;
  @override
  List<Object?> get props => [query];
}

class StockSetDateRangeEvent extends StockEvent {
  const StockSetDateRangeEvent({this.start, this.end});
  final DateTime? start;
  final DateTime? end;
  @override
  List<Object?> get props => [start, end];
}

class StockClearSearchEvent extends StockEvent {
  const StockClearSearchEvent();
}
