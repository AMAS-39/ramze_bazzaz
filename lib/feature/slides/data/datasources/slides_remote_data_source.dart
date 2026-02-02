import 'package:app/core/data_source/remote_data_source/remote_data_source_abs.dart';
import 'package:app/core/shared/imports.dart';
import 'package:app/feature/slides/data/models/create_slide_model.dart';
import 'package:app/feature/slides/data/models/slide_details_model.dart';
import 'package:app/feature/slides/data/models/slides_filter.dart';
import 'package:app/feature/slides/data/models/slides_model.dart';
import 'package:app/feature/slides/data/models/update_slide_model.dart';

class SlidesRemoteOperation {
  late RemoteDataSourceAbs networkOperation;
  SlidesRemoteOperation({required this.networkOperation});
  Future<Either<Failure, ReponseList<SlideModel>>> getSlides({
    required Map<String, dynamic> params,
    required MetaModel metaModel,
    ShowLoading showLoading = ShowLoading.none,
    required SlidesFilterModel slideFilterModel,
    required ShowMessage showMessage,
    int popupTimes = 0,
  }) async {
    return await networkOperation.getData<SlideModel>(
      fromJsonModel: SlideModel.fromMap,
      endPoint: EndPoints.slides,
      parseBody: ParseBody.direct,
      showLoading: showLoading,
      queryParameters: {...params, ...metaModel.toMap()},
      name: Trans.slides.trans(),
      popupTimes: popupTimes,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, SlideDetailsModel?>> getOne(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      ShowLoading showLoading = ShowLoading.none,
      required int recordId}) async {
    return await networkOperation.getOne<SlideDetailsModel>(
      fromJsonModel: SlideDetailsModel.fromMap,
      endPoint: "${EndPoints.slides}/$recordId",
      queryParameters: params,
      showLoading: showLoading,
      name: Trans.slide.trans(),
      popupTimes: popupTimes,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, SlideModel?>> create(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required ShowLoading showLoading,
      required CreateSlideModel model}) async {
    return await networkOperation.create<SlideModel>(
      fromJsonModel: SlideModel.fromMap,
      endPoint: EndPoints.slides,
      queryParameters: params,
      body: model.toMap(),
      showLoading: showLoading,
      name: Trans.slide.trans(),
      popupTimes: popupTimes,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, SlideModel?>> update(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required ShowLoading showLoading,
      required UpdateSlideModel model}) async {
    return await networkOperation.update<SlideModel>(
      fromJsonModel: SlideModel.fromMap,
      endPoint: "${EndPoints.slides}/${model.id}",
      queryParameters: params,
      name: Trans.slide.trans(),
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
      endPoint: "${EndPoints.slides}/$id",
      queryParameters: params,
      name: Trans.slide.trans(),
      popupTimes: popupTimes,
      showLoading: showLoading,
      showMessage: showMessage,
    );
  }
}
