import 'package:app/core/data_source/remote_data_source/remote_data_source_abs.dart';
import 'package:app/core/shared/imports.dart';
import 'package:app/feature/containers/data/models/container_details_model.dart';
import 'package:app/feature/containers/data/models/containers_filter.dart';
import 'package:app/feature/containers/data/models/containers_model.dart';
import 'package:app/feature/containers/data/models/create_container_model.dart';
import 'package:app/feature/containers/data/models/update_container_model.dart';

class ContainersRemoteOperation {
  late RemoteDataSourceAbs networkOperation;
  ContainersRemoteOperation({required this.networkOperation});
  Future<Either<Failure, ReponseList<ContainerModel>>> getContainers({
    required Map<String, dynamic> params,
    required MetaModel metaModel,
    required ContainersFilterModel containerFilterModel,
    required ShowMessage showMessage,
    int popupTimes = 0,
  }) async {
    return await networkOperation.getData<ContainerModel>(
      fromJsonModel: ContainerModel.fromMap,
      endPoint: EndPoints.containers,
      parseBody: ParseBody.direct,
      queryParameters: {...params, ...metaModel.toMap()},
      name: Trans.containers.trans(),
      popupTimes: popupTimes,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, ContainerDetailsModel?>> getOne(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required String recordId}) async {
    return await networkOperation.getOne<ContainerDetailsModel>(
      fromJsonModel: ContainerDetailsModel.fromMap,
      endPoint: "${EndPoints.containers}/$recordId",
      queryParameters: params,
      name: Trans.container.trans(),
      popupTimes: popupTimes,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, ContainerModel?>> create(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required ShowLoading showLoading,
      required CreateContainerModel model}) async {
    return await networkOperation.create<ContainerModel>(
      fromJsonModel: ContainerModel.fromMap,
      endPoint: EndPoints.containers,
      queryParameters: params,
      body: model.toMap(),
      showLoading: showLoading,
      name: Trans.container.trans(),
      popupTimes: popupTimes,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, ContainerModel?>> update(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required ShowLoading showLoading,
      required UpdateContainerModel model}) async {
    return await networkOperation.update<ContainerModel>(
      fromJsonModel: ContainerModel.fromMap,
      endPoint: "${EndPoints.containers}/${model.id}",
      queryParameters: params,
      name: Trans.container.trans(),
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
      endPoint: "${EndPoints.containers}/$id",
      queryParameters: params,
      name: Trans.container.trans(),
      popupTimes: popupTimes,
      showLoading: showLoading,
      showMessage: showMessage,
    );
  }
}
