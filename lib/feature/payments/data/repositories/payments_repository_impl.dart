import 'package:app/core/shared/imports.dart';
import 'package:app/feature/payments/data/datasources/payments_remote_data_source.dart';
import 'package:app/feature/payments/data/models/create_payment_model.dart';
import 'package:app/feature/payments/data/models/payment_details_model.dart';
import 'package:app/feature/payments/data/models/payments_filter.dart';
import 'package:app/feature/payments/data/models/payments_model.dart';
import 'package:app/feature/payments/data/models/update_payment_model.dart';
import 'package:app/feature/payments/domain/repositories/payments_repository.dart';

class PaymentsRepositoryImpl extends PaymentsRepositoryAbs {
  final PaymentsRemoteOperation networkOperation;

  PaymentsRepositoryImpl({
    required this.networkOperation,
  });

  @override
  Future<Either<Failure, PaymentDetailsModel?>> getOne(
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
  Future<Either<Failure, ReponseList<PaymentModel>>> getAll(
      {required PaymentsFilterModel params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      ShowLoading showLoading = ShowLoading.none,
      required DataSource dataSource,
      required MetaModel metaModel}) async {
    final result = await networkOperation.getPayments(
      paymentFilterModel: params,
      metaModel: metaModel,
      params: params.toMap(),
      showMessage: showMessage,
      popupTimes: popupTimes,
    );

    return result;
  }

  @override
  Future<Either<Failure, PaymentModel?>> create(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required DataSource dataSource,
      required ShowLoading showLoading,
      required CreatePaymentModel model}) async {
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
  Future<Either<Failure, PaymentModel?>> update(
      {required id,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required DataSource source,
      required ShowLoading showLoading,
      required UpdatePaymentModel model,
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
