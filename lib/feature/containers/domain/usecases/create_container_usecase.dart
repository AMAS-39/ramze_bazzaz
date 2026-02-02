import 'package:app/core/shared/imports.dart';
import 'package:app/feature/containers/data/models/containers_model.dart';
import 'package:app/feature/containers/data/models/create_container_model.dart';
import 'package:app/feature/containers/domain/repositories/containers_repository.dart';

class CreateContainerUsecase {
  Future<Either<Failure, ContainerModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    required ShowLoading showLoading,
    required CreateContainerModel model,
  }) async {
    return await sl<ContainersRepositoryAbs>().create(
        model: model,
        showLoading: showLoading,
        dataSource: dataSource,
        params: params,
        showMessage: showMessage);
  }
}
