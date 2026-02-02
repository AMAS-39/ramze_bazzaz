import 'package:app/core/shared/imports.dart';
import 'package:app/feature/pay_insteads/data/datasources/pay_insteads_remote_data_source.dart';
import 'package:app/feature/pay_insteads/data/models/create_pay_instead_model.dart';
import 'package:app/feature/pay_insteads/data/models/pay_instead_details_model.dart';
import 'package:app/feature/pay_insteads/data/models/pay_insteads_filter.dart';
import 'package:app/feature/pay_insteads/data/models/pay_insteads_model.dart';
import 'package:app/feature/pay_insteads/data/models/update_pay_instead_model.dart';
import 'package:app/feature/pay_insteads/domain/repositories/pay_insteads_repository.dart';

class PayInsteadsRepositoryImpl extends PayInsteadsRepositoryAbs {
  final PayInsteadsRemoteOperation networkOperation;

  PayInsteadsRepositoryImpl({
    required this.networkOperation,
  });

  @override
  Future<Either<Failure, PayInsteadDetailsModel?>> getOne(
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
  Future<Either<Failure, ReponseList<PayInsteadModel>>> getAll(
      {required PayInsteadsFilterModel params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      ShowLoading showLoading = ShowLoading.none,
      required DataSource dataSource,
      required MetaModel metaModel}) async {
    final result = await networkOperation.getPayInsteads(
      payInsteadFilterModel: params,
      metaModel: metaModel,
      params: params.toMap(),
      showMessage: showMessage,
      popupTimes: popupTimes,
    );

    return result;
  }

  @override
  Future<Either<Failure, PayInsteadModel?>> create(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required DataSource dataSource,
      required ShowLoading showLoading,
      required CreatePayInsteadModel model}) async {
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
  Future<Either<Failure, PayInsteadModel?>> update(
      {required id,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required DataSource source,
      required ShowLoading showLoading,
      required UpdatePayInsteadModel model,
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
