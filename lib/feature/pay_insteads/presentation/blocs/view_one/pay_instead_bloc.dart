import 'package:app/core/shared/imports.dart';
import 'package:app/feature/pay_insteads/data/models/pay_instead_details_model.dart';
import 'package:app/feature/pay_insteads/domain/usecases/get_pay_instead_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pay_instead_event.dart';
part 'pay_instead_state.dart';

class OnePayInsteadBloc extends Bloc<OnePayInsteadEvent, OnePayInsteadState> {
  OnePayInsteadBloc() : super(OnePayInsteadInitialState()) {
    on<OnePayInsteadGetEvent>(onePayInsteadGetEvent);
  }
  Future<Either<Failure, PayInsteadDetailsModel?>> onePayInsteadGetEvent(
      OnePayInsteadGetEvent event, Emitter<OnePayInsteadState> emiter) async {
    emiter(OnePayInsteadLoadingState());

    final result = await sl<GetPayInsteadUsecase>().call(
        params: {},
        id: event.id,
        showMessage: event.showMessage,
        dataSource: event.dataSource);
    logger(result);
    result.fold((failure) {
      if (state is! OnePayInsteadLoadedState) {
        emiter(OnePayInsteadErrorState(failure: failure));
      } else if (state is OnePayInsteadLoadedState) {
        emiter(OnePayInsteadLoadedState(
            data: (state as OnePayInsteadLoadedState).data,
            failure: failure
              ..error.copyWith(message: Trans.canotRefreshPage.trans())));
      }
    }, (data) => emiter(_mapPropsToState(data)));
    logger("state $state");
    return result;
  }

  OnePayInsteadState _mapPropsToState(PayInsteadDetailsModel? payInstead) {
    return payInstead == null
        ? const OnePayInsteadEmptyState()
        : OnePayInsteadLoadedState(failure: null, data: payInstead);
  }
}
