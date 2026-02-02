part of 'pay_insteads_bloc.dart';

class PayInsteadEvent extends Equatable {
  const PayInsteadEvent();

  @override
  List<Object?> get props => [];
}

class PayInsteadEmptyEvent extends PayInsteadEvent {
  const PayInsteadEmptyEvent();
}

class PayInsteadDeleteEvent extends PayInsteadEvent {
  final PayInsteadModel model;
  const PayInsteadDeleteEvent(this.model);
}

class PayInsteadCreateEvent extends PayInsteadEvent {
  final CreatePayInsteadModel model;
  const PayInsteadCreateEvent({
    required this.model,
  });
}

class PayInsteadUpdateEvent extends PayInsteadEvent {
  final UpdatePayInsteadModel model;
  const PayInsteadUpdateEvent({
    required this.model,
  });
}

class PayInsteadLoadEvent extends PayInsteadEvent {
  final ShowMessage showMessage;
  final DataSource dataSource;
  final Function(LoadingMoreEvent)? onDone;
  final PayInsteadsFilterModel filters;
  final bool empty;
  final bool refresh;
  const PayInsteadLoadEvent(
      {required this.filters,
      this.onDone,
      this.empty = false,
      this.refresh = false,
      this.showMessage = ShowMessage.none,
      this.dataSource = DataSource.remote});
  @override
  List<Object?> get props => [dataSource, filters, showMessage, empty];
}
