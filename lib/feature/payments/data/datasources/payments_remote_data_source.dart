import 'package:app/core/data_source/remote_data_source/remote_data_source_abs.dart';
import 'package:app/core/shared/imports.dart';
import 'package:app/feature/payments/data/models/create_payment_model.dart';
import 'package:app/feature/payments/data/models/payment_details_model.dart';
import 'package:app/feature/payments/data/models/payments_filter.dart';
import 'package:app/feature/payments/data/models/payments_model.dart';
import 'package:app/feature/payments/data/models/update_payment_model.dart';

class PaymentsRemoteOperation {
  late RemoteDataSourceAbs networkOperation;
  PaymentsRemoteOperation({required this.networkOperation});
  Future<Either<Failure, ReponseList<PaymentModel>>> getPayments({
    required Map<String, dynamic> params,
    required MetaModel metaModel,
    required PaymentsFilterModel paymentFilterModel,
    required ShowMessage showMessage,
    int popupTimes = 0,
  }) async {
    return await networkOperation.getData<PaymentModel>(
      fromJsonModel: PaymentModel.fromMap,
      endPoint: EndPoints.payments,
      parseBody: ParseBody.direct,
      queryParameters: {...params, ...metaModel.toMap()},
      name: Trans.payments.trans(),
      popupTimes: popupTimes,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, PaymentDetailsModel?>> getOne(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required int recordId}) async {
    return await networkOperation.getOne<PaymentDetailsModel>(
      fromJsonModel: PaymentDetailsModel.fromMap,
      endPoint: "${EndPoints.payments}/$recordId",
      queryParameters: params,
      name: Trans.payment.trans(),
      popupTimes: popupTimes,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, PaymentModel?>> create(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required ShowLoading showLoading,
      required CreatePaymentModel model}) async {
    return await networkOperation.create<PaymentModel>(
      fromJsonModel: PaymentModel.fromMap,
      endPoint: EndPoints.payments,
      queryParameters: params,
      body: model.toMap(),
      showLoading: showLoading,
      name: Trans.payment.trans(),
      popupTimes: popupTimes,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, PaymentModel?>> update(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      int popupTimes = 0,
      required ShowLoading showLoading,
      required UpdatePaymentModel model}) async {
    return await networkOperation.update<PaymentModel>(
      fromJsonModel: PaymentModel.fromMap,
      endPoint: "${EndPoints.payments}/${model.id}",
      queryParameters: params,
      name: Trans.payment.trans(),
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
      endPoint: "${EndPoints.payments}/$id",
      queryParameters: params,
      name: Trans.payment.trans(),
      popupTimes: popupTimes,
      showLoading: showLoading,
      showMessage: showMessage,
    );
  }
}
