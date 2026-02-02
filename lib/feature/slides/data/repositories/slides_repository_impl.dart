import 'package:app/core/shared/imports.dart';
import 'package:app/feature/slides/data/datasources/slides_remote_data_source.dart';
import 'package:app/feature/slides/data/models/create_slide_model.dart';
import 'package:app/feature/slides/data/models/slide_details_model.dart';
import 'package:app/feature/slides/data/models/slides_filter.dart';
import 'package:app/feature/slides/data/models/slides_model.dart';
import 'package:app/feature/slides/data/models/update_slide_model.dart';
import 'package:app/feature/slides/domain/repositories/slides_repository.dart';

class SlidesRepositoryImpl extends SlidesRepositoryAbs {
  final SlidesRemoteOperation networkOperation;

  SlidesRepositoryImpl({
    required this.networkOperation,
  });

  @override
  Future<Either<Failure, SlideDetailsModel?>> getOne(
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
  Future<Either<Failure, ReponseList<SlideModel>>> getAll(
      {required SlidesFilterModel params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      ShowLoading showLoading = ShowLoading.none,
      required DataSource dataSource,
      required MetaModel metaModel}) async {
    final result = await networkOperation.getSlides(
      slideFilterModel: params,
      metaModel: metaModel,
      params: params.toMap(),
      showMessage: showMessage,
      popupTimes: popupTimes,
    );
    return result;
  }

  @override
  Future<Either<Failure, SlideModel?>> create(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required DataSource dataSource,
      required ShowLoading showLoading,
      required CreateSlideModel model}) async {
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
  Future<Either<Failure, SlideModel?>> update(
      {required id,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required DataSource source,
      required ShowLoading showLoading,
      required UpdateSlideModel model,
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
