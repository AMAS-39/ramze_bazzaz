import 'package:app/core/shared/imports.dart';
import 'package:app/feature/container_expenses/data/models/container_expense_details_model.dart';
import 'package:app/feature/container_expenses/domain/usecases/get_container_expense_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'container_expense_event.dart';
part 'container_expense_state.dart';

class OneContainerExpenseBloc
    extends Bloc<OneContainerExpenseEvent, OneContainerExpenseState> {
  OneContainerExpenseBloc() : super(OneContainerExpenseInitialState()) {
    on<OneContainerExpenseGetEvent>(oneContainerExpenseGetEvent);
  }
  Future<Either<Failure, ContainerExpenseDetailsModel?>> oneContainerExpenseGetEvent(OneContainerExpenseGetEvent event,
      Emitter<OneContainerExpenseState> emiter) async {
    emiter(OneContainerExpenseLoadingState());

    final result = await sl<GetContainerExpenseUsecase>().call(
        params: {},
        id: event.id,
        showMessage: event.showMessage,
        dataSource: event.dataSource);
    logger(result);
    result.fold((failure) {
      if (state is! OneContainerExpenseLoadedState) {
        emiter(OneContainerExpenseErrorState(failure: failure));
      } else if (state is OneContainerExpenseLoadedState) {
        emiter(OneContainerExpenseLoadedState(
            data: (state as OneContainerExpenseLoadedState).data,
            failure: failure
              ..error.copyWith(message: Trans.canotRefreshPage.trans())));
      }
    }, (data) => emiter(_mapPropsToState(data)));
    logger("state $state");
    return result;
  }

  OneContainerExpenseState _mapPropsToState(
      ContainerExpenseDetailsModel? containerExpense) {
    return containerExpense == null
        ? const OneContainerExpenseEmptyState()
        : OneContainerExpenseLoadedState(failure: null, data: containerExpense);
  }
}
