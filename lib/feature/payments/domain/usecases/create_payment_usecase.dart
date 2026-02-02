import 'package:app/core/shared/imports.dart';
import 'package:app/feature/payments/data/models/create_payment_model.dart';
import 'package:app/feature/payments/data/models/payments_model.dart';
import 'package:app/feature/payments/domain/repositories/payments_repository.dart';

class CreatePaymentUsecase {
  Future<Either<Failure, PaymentModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    required ShowLoading showLoading,
    required CreatePaymentModel model,
  }) async {
    return await sl<PaymentsRepositoryAbs>().create(
        model: model,
        showLoading: showLoading,
        dataSource: dataSource,
        params: params,
        showMessage: showMessage);
  }
}
