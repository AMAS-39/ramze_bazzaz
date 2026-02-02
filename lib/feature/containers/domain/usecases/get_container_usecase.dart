import 'package:app/core/shared/imports.dart';
import 'package:app/feature/containers/data/models/container_details_model.dart';
import 'package:app/feature/containers/domain/repositories/containers_repository.dart';

class GetContainerUsecase {
  Future<Either<Failure, ContainerDetailsModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    required String id,
  }) async {
    return await sl<ContainersRepositoryAbs>().getOne(
        id: id,
        dataSource: dataSource,
        params: params,
        showMessage: showMessage);
  }
}
