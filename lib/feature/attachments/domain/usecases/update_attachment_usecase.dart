import 'package:app/core/shared/imports.dart';
import 'package:app/feature/attachments/data/models/attachments_model.dart';
import 'package:app/feature/attachments/data/models/update_attachment_model.dart';
import 'package:app/feature/attachments/domain/repositories/attachments_repository.dart';

class UpdateAttachmentUsecase {
  Future<Either<Failure, AttachmentModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    required ShowLoading showLoading,
    required UpdateAttachmentModel model,
  }) async {
    return await sl<AttachmentsRepositoryAbs>().update(
        model: model,
        id: model.id,
        showLoading: showLoading,
        source: dataSource,
        params: params,
        showMessage: showMessage);
  }
}
