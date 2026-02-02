import 'package:app/core/shared/imports.dart';
import 'package:app/feature/payments/data/models/payments_model.dart';
import 'package:app/feature/payments/domain/repositories/payments_repository.dart';

class DeletePaymentUsecase {
  Future<Either<Failure, UnitModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    required ShowLoading showLoading,
    required PaymentModel model,
  }) async {
    return await sl<PaymentsRepositoryAbs>().delete(
        id: model.id,
        showLoading: showLoading,
        params: params,
        showMessage: showMessage);
  }
}
