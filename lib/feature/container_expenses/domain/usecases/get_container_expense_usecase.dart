import 'package:app/core/shared/imports.dart';
import 'package:app/feature/container_expenses/data/models/container_expense_details_model.dart';
import 'package:app/feature/container_expenses/domain/repositories/container_expenses_repository.dart';

class GetContainerExpenseUsecase {
  Future<Either<Failure, ContainerExpenseDetailsModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    ShowLoading showLoading = ShowLoading.none,
    required int id,
  }) async {
    return await sl<ContainerExpensesRepositoryAbs>().getOne(
        id: id,
        showLoading: showLoading,
        dataSource: dataSource,
        params: params,
        showMessage: showMessage);
  }
}
