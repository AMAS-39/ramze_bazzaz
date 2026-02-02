import 'package:app/core/shared/imports.dart';
import 'package:app/feature/attachments/data/models/attachments_filter.dart';
import 'package:app/feature/attachments/data/models/attachments_model.dart';
import 'package:app/feature/attachments/domain/repositories/attachments_repository.dart';

class GetAttachmentsUsecase {
  Future<Either<Failure, ReponseList<AttachmentModel>>> call({
    required AttachmentsFilterModel params,
    required MetaModel metaModel,
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
  }) async {
    return await sl<AttachmentsRepositoryAbs>().getAll(
        dataSource: dataSource,
        params: params,
        metaModel: metaModel,
        showMessage: showMessage);
  }
}
