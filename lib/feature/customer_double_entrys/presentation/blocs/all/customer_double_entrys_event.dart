part of 'customer_double_entrys_bloc.dart';

class CustomerDoubleEntryEvent extends Equatable {
  const CustomerDoubleEntryEvent();

  @override
  List<Object?> get props => [];
}

class CustomerDoubleEntryEmptyEvent extends CustomerDoubleEntryEvent {
  const CustomerDoubleEntryEmptyEvent();
}



class CustomerDoubleEntryDeleteEvent extends CustomerDoubleEntryEvent {
  final CustomerDoubleEntryModel model;
  const CustomerDoubleEntryDeleteEvent(this.model);
}

class CustomerDoubleEntryCreateEvent extends CustomerDoubleEntryEvent {
  final CreateCustomerDoubleEntryModel model;
  const CustomerDoubleEntryCreateEvent({
    required this.model,
  });
}
class CustomerDoubleEntryUpdateEvent extends CustomerDoubleEntryEvent {
  final UpdateCustomerDoubleEntryModel model;
  const CustomerDoubleEntryUpdateEvent({
    required this.model,
  });
}

class CustomerDoubleEntryLoadEvent extends CustomerDoubleEntryEvent {
  final ShowMessage showMessage;
  final DataSource dataSource;
  final Function(LoadingMoreEvent)? onDone;
  final CustomerDoubleEntrysFilterModel filters;
  final bool empty;
  final bool refresh;
  const CustomerDoubleEntryLoadEvent(
      {required this.filters,
      this.onDone,
      this.empty = false,     
       this.refresh = false,

      this.showMessage = ShowMessage.none,
      this.dataSource = DataSource.remote});
  @override
  List<Object?> get props => [dataSource, filters, showMessage, empty];
}
