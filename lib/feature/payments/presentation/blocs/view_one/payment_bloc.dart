import 'package:app/core/shared/imports.dart';
import 'package:app/feature/payments/data/models/payment_details_model.dart';
import 'package:app/feature/payments/domain/usecases/get_payment_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class OnePaymentBloc extends Bloc<OnePaymentEvent, OnePaymentState> {
  OnePaymentBloc() : super(OnePaymentInitialState()) {
    on<OnePaymentGetEvent>(onePaymentGetEvent);
  }
  Future<Either<Failure, PaymentDetailsModel?>> onePaymentGetEvent(
      OnePaymentGetEvent event, Emitter<OnePaymentState> emiter) async {
    emiter(OnePaymentLoadingState());

    final result = await sl<GetPaymentUsecase>().call(
        params: {},
        id: event.id,
        showMessage: event.showMessage,
        dataSource: event.dataSource);
    logger(result);
    result.fold((failure) {
      if (state is! OnePaymentLoadedState) {
        emiter(OnePaymentErrorState(failure: failure));
      } else if (state is OnePaymentLoadedState) {
        emiter(OnePaymentLoadedState(
            data: (state as OnePaymentLoadedState).data,
            failure: failure
              ..error.copyWith(message: Trans.canotRefreshPage.trans())));
      }
    }, (data) => emiter(_mapPropsToState(data)));
    logger("state $state");
    return result;
  }

  OnePaymentState _mapPropsToState(PaymentDetailsModel? payment) {
    return payment == null
        ? const OnePaymentEmptyState()
        : OnePaymentLoadedState(failure: null, data: payment);
  }
}
