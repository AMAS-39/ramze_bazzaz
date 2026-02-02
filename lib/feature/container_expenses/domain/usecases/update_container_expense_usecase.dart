import 'package:app/core/shared/imports.dart';
import 'package:app/feature/container_expenses/data/models/container_expenses_model.dart';
import 'package:app/feature/container_expenses/data/models/update_container_expense_model.dart';
import 'package:app/feature/container_expenses/domain/repositories/container_expenses_repository.dart';

class UpdateContainerExpenseUsecase {
  Future<Either<Failure, ContainerExpenseModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    required ShowLoading showLoading,
    required UpdateContainerExpenseModel model,
  }) async {
    return await sl<ContainerExpensesRepositoryAbs>().update(
        model: model,
        id: model.id,
        showLoading: showLoading,
        source: dataSource,
        params: params,
        showMessage: showMessage);
  }
}
