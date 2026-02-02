import 'package:app/core/shared/imports.dart';
import 'package:app/feature/packages/data/models/packages_filter.dart';
import 'package:app/feature/packages/data/models/packages_model.dart';
import 'package:app/feature/packages/domain/repositories/packages_repository.dart';

class GetPackagesUsecase {
  Future<Either<Failure, ReponseList<PackageModel>>> call({
    required PackagesFilterModel params,
    required MetaModel metaModel,
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
  }) async {
    return await sl<PackagesRepositoryAbs>().getAll(
        dataSource: dataSource,
        params: params,
        metaModel: metaModel,
        showMessage: showMessage);
  }
}
