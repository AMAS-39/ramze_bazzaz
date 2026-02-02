import 'package:app/core/shared/imports.dart';
import 'package:app/feature/packages/data/models/packages_model.dart';
import 'package:app/feature/packages/data/models/update_package_model.dart';
import 'package:app/feature/packages/domain/repositories/packages_repository.dart';

class UpdatePackageUsecase {
  Future<Either<Failure, PackageModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    required ShowLoading showLoading,
    required UpdatePackageModel model,
  }) async {
    return await sl<PackagesRepositoryAbs>().update(
        model: model,
        id: model.id,
        showLoading: showLoading,
        source: dataSource,
        params: params,
        showMessage: showMessage);
  }
}
