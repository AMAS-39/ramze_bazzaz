import 'package:app/core/shared/imports.dart';
import 'package:app/feature/slides/data/models/slides_model.dart';
import 'package:app/feature/slides/domain/repositories/slides_repository.dart';

class DeleteSlideUsecase {
  Future<Either<Failure, UnitModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    required ShowLoading showLoading,
    required SlideModel model,
  }) async {
    return await sl<SlidesRepositoryAbs>().delete(
        id: model.id,
        showLoading: showLoading,
        params: params,
        showMessage: showMessage);
  }
}
