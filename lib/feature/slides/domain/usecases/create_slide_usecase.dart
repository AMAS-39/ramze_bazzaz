import 'package:app/core/shared/imports.dart';
import 'package:app/feature/slides/data/models/create_slide_model.dart';
import 'package:app/feature/slides/data/models/slides_model.dart';
import 'package:app/feature/slides/domain/repositories/slides_repository.dart';

class CreateSlideUsecase {
  Future<Either<Failure, SlideModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    required ShowLoading showLoading,
    required CreateSlideModel model,
  }) async {
    return await sl<SlidesRepositoryAbs>().create(
        model: model,
        showLoading: showLoading,
        dataSource: dataSource,
        params: params,
        showMessage: showMessage);
  }
}
