import 'package:app/core/shared/imports.dart';
import 'package:app/feature/payments/data/models/payments_filter.dart';
import 'package:app/feature/payments/data/models/payments_model.dart';
import 'package:app/feature/payments/domain/repositories/payments_repository.dart';

class GetPaymentsUsecase {
  Future<Either<Failure, ReponseList<PaymentModel>>> call({
    required PaymentsFilterModel params,
    required MetaModel metaModel,
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
  }) async {
    return await sl<PaymentsRepositoryAbs>().getAll(
        dataSource: dataSource,
        params: params,
        metaModel: metaModel,
        showMessage: showMessage);
  }
}
