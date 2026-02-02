import 'package:app/core/shared/imports.dart';
import 'package:app/feature/slides/data/models/slides_filter.dart';
import 'package:app/feature/slides/data/models/slides_model.dart';
import 'package:app/feature/slides/domain/repositories/slides_repository.dart';

class GetSlidesUsecase {
  Future<Either<Failure, ReponseList<SlideModel>>> call({
    required SlidesFilterModel params,
    required MetaModel metaModel,
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    ShowLoading showLoading = ShowLoading.none,
  }) async {
    return await sl<SlidesRepositoryAbs>().getAll(
        showLoading: showLoading,
        dataSource: dataSource,
        params: params,
        metaModel: metaModel,
        showMessage: showMessage);
  }
}
