import 'package:app/core/shared/imports.dart';
import 'package:app/feature/containers/data/models/containers_model.dart';
import 'package:app/feature/containers/data/models/update_container_model.dart';
import 'package:app/feature/containers/domain/repositories/containers_repository.dart';

class UpdateContainerUsecase {
  Future<Either<Failure, ContainerModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    required ShowLoading showLoading,
    required UpdateContainerModel model,
  }) async {
    return await sl<ContainersRepositoryAbs>().update(
        model: model,
        id: model.id,
        showLoading: showLoading,
        source: dataSource,
        params: params,
        showMessage: showMessage);
  }
}
