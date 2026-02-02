import 'package:app/core/shared/imports.dart';
import 'package:app/feature/packages/data/datasources/packages_remote_data_source.dart';
import 'package:app/feature/packages/data/models/create_package_model.dart';
import 'package:app/feature/packages/data/models/package_details_model.dart';
import 'package:app/feature/packages/data/models/packages_filter.dart';
import 'package:app/feature/packages/data/models/packages_model.dart';
import 'package:app/feature/packages/data/models/update_package_model.dart';
import 'package:app/feature/packages/domain/repositories/packages_repository.dart';

class PackagesRepositoryImpl extends PackagesRepositoryAbs {
  final PackagesRemoteOperation networkOperation;

  PackagesRepositoryImpl({
    required this.networkOperation,
  });

  @override
  Future<Either<Failure, PackageDetailsModel?>> getOne(
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
  Future<Either<Failure, ReponseList<PackageModel>>> getAll(
      {required PackagesFilterModel params,
      required ShowMessage showMessage,
      ShowLoading showLoading = ShowLoading.none,
      int popupTimes = 0,
      required DataSource dataSource,
      required MetaModel metaModel}) async {
    final result = await networkOperation.getPackages(
      packageFilterModel: params,
      metaModel: metaModel,
      params: params.toMap(),
      showMessage: showMessage,
      popupTimes: popupTimes,
    );
    return result;
  }

  @override
  Future<Either<Failure, PackageModel?>> create(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required DataSource dataSource,
      required ShowLoading showLoading,
      required CreatePackageModel model}) async {
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
  Future<Either<Failure, PackageModel?>> update(
      {required id,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required DataSource source,
      required ShowLoading showLoading,
      required UpdatePackageModel model,
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
