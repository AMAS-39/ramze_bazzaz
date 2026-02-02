import 'package:app/core/shared/imports.dart';
import 'package:app/feature/payments/data/models/payment_details_model.dart';
import 'package:app/feature/payments/domain/repositories/payments_repository.dart';

class GetPaymentUsecase {
  Future<Either<Failure, PaymentDetailsModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    required int id,
  }) async {
    return await sl<PaymentsRepositoryAbs>().getOne(
        id: id,
        dataSource: dataSource,
        params: params,
        showMessage: showMessage);
  }
}
