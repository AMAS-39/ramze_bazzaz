import 'package:app/core/shared/imports.dart';
import 'package:app/feature/container_expenses/data/models/container_expenses_model.dart';
import 'package:app/feature/container_expenses/domain/repositories/container_expenses_repository.dart';

class DeleteContainerExpenseUsecase {
  Future<Either<Failure, UnitModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    required ShowLoading showLoading,
    required ContainerExpenseModel model,
  }) async {
    return await sl<ContainerExpensesRepositoryAbs>().delete(
        id: model.id,
        showLoading: showLoading,
        params: params,
        showMessage: showMessage);
  }
}
