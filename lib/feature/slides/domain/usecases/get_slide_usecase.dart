import 'package:app/core/shared/imports.dart';
import 'package:app/feature/slides/data/models/slide_details_model.dart';
import 'package:app/feature/slides/domain/repositories/slides_repository.dart';

class GetSlideUsecase {
  Future<Either<Failure, SlideDetailsModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    ShowLoading showLoading = ShowLoading.none,
    required int id,
  }) async {
    return await sl<SlidesRepositoryAbs>().getOne(
        id: id,
        showLoading: showLoading,
        dataSource: dataSource,
        params: params,
        showMessage: showMessage);
  }
}
