import 'package:app/core/shared/imports.dart';
import 'package:app/feature/attachments/data/models/attachment_details_model.dart';
import 'package:app/feature/attachments/domain/repositories/attachments_repository.dart';

class GetAttachmentUsecase {
  Future<Either<Failure, AttachmentDetailsModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    required int id,
  }) async {
    return await sl<AttachmentsRepositoryAbs>().getOne(
        id: id,
        dataSource: dataSource,
        params: params,
        showMessage: showMessage);
  }
}
