import 'package:app/core/shared/imports.dart';
import 'package:app/feature/containers/data/models/containers_filter.dart';
import 'package:app/feature/containers/data/models/containers_model.dart';
import 'package:app/feature/containers/domain/repositories/containers_repository.dart';

class GetContainersUsecase {
  Future<Either<Failure, ReponseList<ContainerModel>>> call({
    required ContainersFilterModel params,
    required MetaModel metaModel,
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
  }) async {
    return await sl<ContainersRepositoryAbs>().getAll(
        dataSource: dataSource,
        params: params,
        metaModel: metaModel,
        showMessage: showMessage);
  }
}
