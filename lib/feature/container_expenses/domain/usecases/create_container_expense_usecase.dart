import 'package:app/core/shared/imports.dart';
import 'package:app/feature/container_expenses/data/models/container_expenses_model.dart';
import 'package:app/feature/container_expenses/data/models/create_container_expense_model.dart';
import 'package:app/feature/container_expenses/domain/repositories/container_expenses_repository.dart';

class CreateContainerExpenseUsecase {
  Future<Either<Failure, ContainerExpenseModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    required ShowLoading showLoading,
    required CreateContainerExpenseModel model,
  }) async {
    return await sl<ContainerExpensesRepositoryAbs>().create(
        model: model,
        showLoading: showLoading,
        dataSource: dataSource,
        params: params,
        showMessage: showMessage);
  }
}
