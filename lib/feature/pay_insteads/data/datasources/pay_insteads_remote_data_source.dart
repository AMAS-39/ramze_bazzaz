import 'package:app/core/data_source/remote_data_source/remote_data_source_abs.dart';
import 'package:app/core/shared/imports.dart';
import 'package:app/feature/pay_insteads/data/models/create_pay_instead_model.dart';
import 'package:app/feature/pay_insteads/data/models/pay_instead_details_model.dart';
import 'package:app/feature/pay_insteads/data/models/pay_insteads_filter.dart';
import 'package:app/feature/pay_insteads/data/models/pay_insteads_model.dart';
import 'package:app/feature/pay_insteads/data/models/update_pay_instead_model.dart';

class PayInsteadsRemoteOperation {
  late RemoteDataSourceAbs networkOperation;
  PayInsteadsRemoteOperation({required this.networkOperation});
  Future<Either<Failure, ReponseList<PayInsteadModel>>> getPayInsteads({
    required Map<String, dynamic> params,
    required MetaModel metaModel,
    required PayInsteadsFilterModel payInsteadFilterModel,
    required ShowMessage showMessage,
    int popupTimes = 0,
  }) async {
    return await networkOperation.getData<PayInsteadModel>(
      fromJsonModel: PayInsteadModel.fromMap,
      endPoint: EndPoints.payInsteads,
      parseBody: ParseBody.direct,
      queryParameters: {...params, ...metaModel.toMap()},
      name: Trans.payInsteads.trans(),
      popupTimes: popupTimes,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, PayInsteadDetailsModel?>> getOne(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required int recordId}) async {
    return await networkOperation.getOne<PayInsteadDetailsModel>(
      fromJsonModel: PayInsteadDetailsModel.fromMap,
      endPoint: "${EndPoints.payInsteads}/$recordId",
      queryParameters: params,
      name: Trans.payInstead.trans(),
      popupTimes: popupTimes,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, PayInsteadModel?>> create(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required ShowLoading showLoading,
      required CreatePayInsteadModel model}) async {
    return await networkOperation.create<PayInsteadModel>(
      fromJsonModel: PayInsteadModel.fromMap,
      endPoint: EndPoints.payInsteads,
      queryParameters: params,
      body: model.toMap(),
      showLoading: showLoading,
      name: Trans.payInstead.trans(),
      popupTimes: popupTimes,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, PayInsteadModel?>> update(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required ShowLoading showLoading,
      required UpdatePayInsteadModel model}) async {
    return await networkOperation.update<PayInsteadModel>(
      fromJsonModel: PayInsteadModel.fromMap,
      endPoint: "${EndPoints.payInsteads}/${model.id}",
      queryParameters: params,
      name: Trans.payInstead.trans(),
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
      endPoint: "${EndPoints.payInsteads}/$id",
      queryParameters: params,
      name: Trans.payInstead.trans(),
      popupTimes: popupTimes,
      showLoading: showLoading,
      showMessage: showMessage,
    );
  }
}
