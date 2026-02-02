import 'package:app/core/shared/imports.dart';
import 'package:app/feature/packages/data/models/package_details_model.dart';
import 'package:app/feature/packages/domain/repositories/packages_repository.dart';

class GetPackageUsecase {
  Future<Either<Failure, PackageDetailsModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    required int id,
  }) async {
    return await sl<PackagesRepositoryAbs>().getOne(
        id: id,
        dataSource: dataSource,
        params: params,
        showMessage: showMessage);
  }
}
