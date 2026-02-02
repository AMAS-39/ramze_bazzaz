import 'package:app/core/shared/imports.dart';
import 'package:app/feature/packages/data/models/package_details_model.dart';
import 'package:app/feature/packages/domain/usecases/get_package_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'package_event.dart';
part 'package_state.dart';

class OnePackageBloc extends Bloc<OnePackageEvent, OnePackageState> {
  OnePackageBloc() : super(OnePackageInitialState()) {
    on<OnePackageGetEvent>(onePackageGetEvent);
  }
  Future<Either<Failure, PackageDetailsModel?>> onePackageGetEvent(
      OnePackageGetEvent event, Emitter<OnePackageState> emiter) async {
    emiter(OnePackageLoadingState());

    final result = await sl<GetPackageUsecase>().call(
        params: {},
        id: event.id,
        showMessage: event.showMessage,
        dataSource: event.dataSource);
    logger(result);
    result.fold((failure) {
      if (state is! OnePackageLoadedState) {
        emiter(OnePackageErrorState(failure: failure));
      } else if (state is OnePackageLoadedState) {
        emiter(OnePackageLoadedState(
            data: (state as OnePackageLoadedState).data,
            failure: failure
              ..error.copyWith(message: Trans.canotRefreshPage.trans())));
      }
    }, (data) => emiter(_mapPropsToState(data)));
    logger("state $state");
    return result;
  }

  OnePackageState _mapPropsToState(PackageDetailsModel? package) {
    return package == null
        ? const OnePackageEmptyState()
        : OnePackageLoadedState(failure: null, data: package);
  }
}
