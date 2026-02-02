import 'package:app/core/shared/imports.dart';
import 'package:app/feature/container_expenses/data/models/container_expenses_filter.dart';
import 'package:app/feature/container_expenses/data/models/container_expenses_model.dart';
import 'package:app/feature/container_expenses/domain/repositories/container_expenses_repository.dart';

class GetContainerExpensesUsecase {
  Future<Either<Failure, ReponseList<ContainerExpenseModel>>> call({
    required ContainerExpensesFilterModel params,
    required MetaModel metaModel,
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    ShowLoading showLoading = ShowLoading.none,
  }) async {
    return await sl<ContainerExpensesRepositoryAbs>().getAll(
        showLoading: showLoading,
        dataSource: dataSource,
        params: params,
        metaModel: metaModel,
        showMessage: showMessage);
  }
}
