import 'package:app/core/shared/imports.dart';
import 'package:app/feature/slides/data/models/slides_model.dart';
import 'package:app/feature/slides/data/models/update_slide_model.dart';
import 'package:app/feature/slides/domain/repositories/slides_repository.dart';

class UpdateSlideUsecase {
  Future<Either<Failure, SlideModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    required ShowLoading showLoading,
    required UpdateSlideModel model,
  }) async {
    return await sl<SlidesRepositoryAbs>().update(
        model: model,
        id: model.id,
        showLoading: showLoading,
        source: dataSource,
        params: params,
        showMessage: showMessage);
  }
}
