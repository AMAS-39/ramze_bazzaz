import 'package:app/core/shared/imports.dart';
import 'package:app/feature/packages/data/models/packages_model.dart';
import 'package:app/feature/packages/domain/repositories/packages_repository.dart';

class DeletePackageUsecase {
  Future<Either<Failure, UnitModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    required ShowLoading showLoading,
    required PackageModel model,
  }) async {
    return await sl<PackagesRepositoryAbs>().delete(
        id: model.id,
        showLoading: showLoading,
        params: params,
        showMessage: showMessage);
  }
}
