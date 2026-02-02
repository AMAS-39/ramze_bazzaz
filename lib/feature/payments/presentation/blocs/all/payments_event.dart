part of 'payments_bloc.dart';

class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class PaymentEmptyEvent extends PaymentEvent {
  const PaymentEmptyEvent();
}



class PaymentDeleteEvent extends PaymentEvent {
  final PaymentModel model;
  const PaymentDeleteEvent(this.model);
}

class PaymentCreateEvent extends PaymentEvent {
  final CreatePaymentModel model;
  const PaymentCreateEvent({
    required this.model,
  });
}
class PaymentUpdateEvent extends PaymentEvent {
  final UpdatePaymentModel model;
  const PaymentUpdateEvent({
    required this.model,
  });
}

class PaymentLoadEvent extends PaymentEvent {
  final ShowMessage showMessage;
  final DataSource dataSource;
  final Function(LoadingMoreEvent)? onDone;
  final PaymentsFilterModel filters;
  final bool empty;
  final bool refresh;
  const PaymentLoadEvent(
      {required this.filters,
      this.onDone,
      this.empty = false,     
       this.refresh = false,

      this.showMessage = ShowMessage.none,
      this.dataSource = DataSource.remote});
  @override
  List<Object?> get props => [dataSource, filters, showMessage, empty];
}
