import 'package:app/core/data_source/remote_data_source/remote_data_source_abs.dart';
import 'package:app/core/shared/imports.dart';
import 'package:app/feature/attachments/data/models/attachment_details_model.dart';
import 'package:app/feature/attachments/data/models/attachments_filter.dart';
import 'package:app/feature/attachments/data/models/attachments_model.dart';
import 'package:app/feature/attachments/data/models/create_attachment_model.dart';
import 'package:app/feature/attachments/data/models/update_attachment_model.dart';

class AttachmentsRemoteOperation {
  late RemoteDataSourceAbs networkOperation;
  AttachmentsRemoteOperation({required this.networkOperation});
  Future<Either<Failure, ReponseList<AttachmentModel>>> getAttachments({
    required Map<String, dynamic> params,
    required MetaModel metaModel,
    required AttachmentsFilterModel attachmentFilterModel,
    required ShowMessage showMessage,
    int popupTimes = 0,
  }) async {
    return await networkOperation.getData<AttachmentModel>(
      fromJsonModel: AttachmentModel.fromMap,
      endPoint: EndPoints.attachments,
      parseBody: ParseBody.direct,
      queryParameters: {...params, ...metaModel.toMap()},
      name: Trans.attachments.trans(),
      popupTimes: popupTimes,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, AttachmentDetailsModel?>> getOne(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required int recordId}) async {
    return await networkOperation.getOne<AttachmentDetailsModel>(
      fromJsonModel: AttachmentDetailsModel.fromMap,
      endPoint: "${EndPoints.attachments}/$recordId",
      queryParameters: params,
      name: Trans.attachment.trans(),
      popupTimes: popupTimes,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, AttachmentModel?>> create(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required ShowLoading showLoading,
      required CreateAttachmentModel model}) async {
    return await networkOperation.create<AttachmentModel>(
      fromJsonModel: AttachmentModel.fromMap,
      endPoint: EndPoints.attachments,
      queryParameters: params,
      body: model.toMap(),
      showLoading: showLoading,
      name: Trans.attachment.trans(),
      popupTimes: popupTimes,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, AttachmentModel?>> update(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required ShowLoading showLoading,
      required UpdateAttachmentModel model}) async {
    return await networkOperation.update<AttachmentModel>(
      fromJsonModel: AttachmentModel.fromMap,
      endPoint: "${EndPoints.attachments}/${model.id}",
      queryParameters: params,
      name: Trans.attachment.trans(),
      popupTimes: popupTimes,
      isForm: false,
      showLoading: showLoading,
      body: model.toMap(),
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, UnitModel?>> delete(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required ShowLoading showLoading,
      required int id}) async {
    return await networkOperation.delete<UnitModel>(
      fromJsonModel: UnitModel.fromMap,
      endPoint: "${EndPoints.attachments}/$id",
      queryParameters: params,
      name: Trans.attachment.trans(),
      popupTimes: popupTimes,
      showLoading: showLoading,
      showMessage: showMessage,
    );
  }
}
