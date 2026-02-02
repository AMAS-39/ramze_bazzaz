import 'package:app/core/data_source/remote_data_source/remote_data_source_abs.dart';
import 'package:app/core/shared/imports.dart';
import 'package:app/feature/packages/data/models/create_package_model.dart';
import 'package:app/feature/packages/data/models/package_details_model.dart';
import 'package:app/feature/packages/data/models/packages_filter.dart';
import 'package:app/feature/packages/data/models/packages_model.dart';
import 'package:app/feature/packages/data/models/update_package_model.dart';

class PackagesRemoteOperation {
  late RemoteDataSourceAbs networkOperation;
  PackagesRemoteOperation({required this.networkOperation});
  Future<Either<Failure, ReponseList<PackageModel>>> getPackages({
    required Map<String, dynamic> params,
    required MetaModel metaModel,
    required PackagesFilterModel packageFilterModel,
    required ShowMessage showMessage,
    int popupTimes = 0,
  }) async {
    return await networkOperation.getData<PackageModel>(
      fromJsonModel: PackageModel.fromMap,
      endPoint: EndPoints.packages,
      parseBody: ParseBody.direct,
      queryParameters: {...params, ...metaModel.toMap()},
      name: Trans.packages.trans(),
      popupTimes: popupTimes,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, PackageDetailsModel?>> getOne(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required int recordId}) async {
    return await networkOperation.getOne<PackageDetailsModel>(
      fromJsonModel: PackageDetailsModel.fromMap,
      endPoint: "${EndPoints.packages}/$recordId",
      queryParameters: params,
      name: Trans.package.trans(),
      popupTimes: popupTimes,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, PackageModel?>> create(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required ShowLoading showLoading,
      required CreatePackageModel model}) async {
    return await networkOperation.create<PackageModel>(
      fromJsonModel: PackageModel.fromMap,
      endPoint: EndPoints.packages,
      queryParameters: params,
      body: model.toMap(),
      showLoading: showLoading,
      name: Trans.package.trans(),
      popupTimes: popupTimes,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, PackageModel?>> update(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required ShowLoading showLoading,
      required UpdatePackageModel model}) async {
    return await networkOperation.update<PackageModel>(
      fromJsonModel: PackageModel.fromMap,
      endPoint: "${EndPoints.packages}/${model.id}",
      queryParameters: params,
      name: Trans.package.trans(),
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
      endPoint: "${EndPoints.packages}/$id",
      queryParameters: params,
      name: Trans.package.trans(),
      popupTimes: popupTimes,
      showLoading: showLoading,
      showMessage: showMessage,
    );
  }
}
