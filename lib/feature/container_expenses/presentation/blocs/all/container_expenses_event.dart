part of 'container_expenses_bloc.dart';

class ContainerExpenseEvent extends Equatable {
  const ContainerExpenseEvent();

  @override
  List<Object?> get props => [];
}

class ContainerExpenseEmptyEvent extends ContainerExpenseEvent {
  const ContainerExpenseEmptyEvent();
}



class ContainerExpenseDeleteEvent extends ContainerExpenseEvent {
  final ContainerExpenseModel model;
  const ContainerExpenseDeleteEvent(this.model);
}

class ContainerExpenseCreateEvent extends ContainerExpenseEvent {
  final CreateContainerExpenseModel model;
  const ContainerExpenseCreateEvent({
    required this.model,
  });
}
class ContainerExpenseUpdateEvent extends ContainerExpenseEvent {
  final UpdateContainerExpenseModel model;
  const ContainerExpenseUpdateEvent({
    required this.model,
  });
}

class ContainerExpenseLoadEvent extends ContainerExpenseEvent {
  final ShowMessage showMessage;
  final DataSource dataSource;
  final Function(LoadingMoreEvent)? onDone;
  final ContainerExpensesFilterModel filters;
  final bool empty;
  final bool refresh;
  const ContainerExpenseLoadEvent(
      {required this.filters,
      this.onDone,
      this.empty = false,     
       this.refresh = false,

      this.showMessage = ShowMessage.none,
      this.dataSource = DataSource.remote});
  @override
  List<Object?> get props => [dataSource, filters, showMessage, empty];
}
