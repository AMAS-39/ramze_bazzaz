import 'package:app/core/shared/imports.dart';
import 'package:app/feature/payments/data/models/payments_model.dart';
import 'package:app/feature/payments/data/models/update_payment_model.dart';
import 'package:app/feature/payments/domain/repositories/payments_repository.dart';

class UpdatePaymentUsecase {
  Future<Either<Failure, PaymentModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    required ShowLoading showLoading,
    required UpdatePaymentModel model,
  }) async {
    return await sl<PaymentsRepositoryAbs>().update(
        model: model,
        id: model.id,
        showLoading: showLoading,
        source: dataSource,
        params: params,
        showMessage: showMessage);
  }
}
