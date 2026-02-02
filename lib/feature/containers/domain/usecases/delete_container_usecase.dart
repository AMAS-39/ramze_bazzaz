import 'package:app/core/shared/imports.dart';
import 'package:app/feature/containers/data/models/containers_model.dart';
import 'package:app/feature/containers/domain/repositories/containers_repository.dart';

class DeleteContainerUsecase {
  Future<Either<Failure, UnitModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    required ShowLoading showLoading,
    required ContainerModel model,
  }) async {
    return await sl<ContainersRepositoryAbs>().delete(
        id: model.id,
        showLoading: showLoading,
        params: params,
        showMessage: showMessage);
  }
}
