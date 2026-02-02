import 'package:app/core/shared/imports.dart';
import 'package:app/feature/packages/data/models/create_package_model.dart';
import 'package:app/feature/packages/data/models/packages_model.dart';
import 'package:app/feature/packages/domain/repositories/packages_repository.dart';

class CreatePackageUsecase {
  Future<Either<Failure, PackageModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    required ShowLoading showLoading,
    required CreatePackageModel model,
  }) async {
    return await sl<PackagesRepositoryAbs>().create(
        model: model,
        showLoading: showLoading,
        dataSource: dataSource,
        params: params,
        showMessage: showMessage);
  }
}
