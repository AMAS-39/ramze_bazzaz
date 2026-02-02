import 'package:app/core/shared/imports.dart';
import 'package:app/feature/customer_double_entrys/data/models/customer_double_entry_details_model.dart';
import 'package:app/feature/customer_double_entrys/domain/usecases/get_customer_double_entry_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'customer_double_entry_event.dart';
part 'customer_double_entry_state.dart';

class OneCustomerDoubleEntryBloc
    extends Bloc<OneCustomerDoubleEntryEvent, OneCustomerDoubleEntryState> {
  OneCustomerDoubleEntryBloc() : super(OneCustomerDoubleEntryInitialState()) {
    on<OneCustomerDoubleEntryGetEvent>(oneCustomerDoubleEntryGetEvent);
  }
  Future<Either<Failure, CustomerDoubleEntryDetailsModel?>> oneCustomerDoubleEntryGetEvent(OneCustomerDoubleEntryGetEvent event,
      Emitter<OneCustomerDoubleEntryState> emiter) async {
    emiter(OneCustomerDoubleEntryLoadingState());

    final result = await sl<GetCustomerDoubleEntryUsecase>().call(
        params: {},
        id: event.id,
        showMessage: event.showMessage,
        dataSource: event.dataSource);
    logger(result);
    result.fold((failure) {
      if (state is! OneCustomerDoubleEntryLoadedState) {
        emiter(OneCustomerDoubleEntryErrorState(failure: failure));
      } else if (state is OneCustomerDoubleEntryLoadedState) {
        emiter(OneCustomerDoubleEntryLoadedState(
            data: (state as OneCustomerDoubleEntryLoadedState).data,
            failure: failure
              ..error.copyWith(message: Trans.canotRefreshPage.trans())));
      }
    }, (data) => emiter(_mapPropsToState(data)));
    logger("state $state");
    return result;
  }

  OneCustomerDoubleEntryState _mapPropsToState(
      CustomerDoubleEntryDetailsModel? customerDoubleEntry) {
    return customerDoubleEntry == null
        ? const OneCustomerDoubleEntryEmptyState()
        : OneCustomerDoubleEntryLoadedState(
            failure: null, data: customerDoubleEntry);
  }
}
