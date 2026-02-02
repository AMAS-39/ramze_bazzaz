import 'package:app/core/shared/imports.dart';
import 'package:app/feature/attachments/data/datasources/attachments_remote_data_source.dart';
import 'package:app/feature/attachments/data/models/attachment_details_model.dart';
import 'package:app/feature/attachments/data/models/attachments_filter.dart';
import 'package:app/feature/attachments/data/models/attachments_model.dart';
import 'package:app/feature/attachments/data/models/create_attachment_model.dart';
import 'package:app/feature/attachments/data/models/update_attachment_model.dart';
import 'package:app/feature/attachments/domain/repositories/attachments_repository.dart';

class AttachmentsRepositoryImpl extends AttachmentsRepositoryAbs {
  final AttachmentsRemoteOperation networkOperation;

  AttachmentsRepositoryImpl({
    required this.networkOperation,
  });

  @override
  Future<Either<Failure, AttachmentDetailsModel?>> getOne(
      {required int id,
      required ShowMessage showMessage,
      ShowLoading showLoading = ShowLoading.none,
      int popupTimes = 0,
      required DataSource dataSource,
      Map<String, String> params = const {}}) async {
    final res = await networkOperation.getOne(
        popupTimes: popupTimes,
        recordId: id,
        params: params,
        showMessage: showMessage);

    return res;
  }

  @override
  Future<Either<Failure, ReponseList<AttachmentModel>>> getAll(
      {required AttachmentsFilterModel params,
      required ShowMessage showMessage,
      ShowLoading showLoading = ShowLoading.none,
      int popupTimes = 0,
      required DataSource dataSource,
      required MetaModel metaModel}) async {
    final result = await networkOperation.getAttachments(
      attachmentFilterModel: params,
      metaModel: metaModel,
      params: params.toMap(),
      showMessage: showMessage,
      popupTimes: popupTimes,
    );

    return result;
  }

  @override
  Future<Either<Failure, AttachmentModel?>> create(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required DataSource dataSource,
      required ShowLoading showLoading,
      required CreateAttachmentModel model}) async {
    final res = await networkOperation.create(
        showLoading: showLoading,
        params: params,
        popupTimes: popupTimes,
        showMessage: showMessage,
        model: model);

    return res;
  }

  @override
  Future<Either<Failure, UnitModel?>> delete(
      {required int id,
      required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required ShowLoading showLoading}) async {
    final res = await networkOperation.delete(
        params: params,
        showMessage: showMessage,
        showLoading: showLoading,
        popupTimes: popupTimes,
        id: id);

    return res;
  }

  @override
  Future<Either<Failure, AttachmentModel?>> update(
      {required id,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required DataSource source,
      required ShowLoading showLoading,
      required UpdateAttachmentModel model,
      Map<String, String> params = const {}}) async {
    final res = await networkOperation.update(
        params: params,
        showMessage: showMessage,
        popupTimes: popupTimes,
        showLoading: showLoading,
        model: model);

    return res;
  }
}
