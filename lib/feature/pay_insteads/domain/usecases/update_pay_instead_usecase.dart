import 'package:app/core/shared/imports.dart';
import 'package:app/feature/pay_insteads/data/models/pay_insteads_model.dart';
import 'package:app/feature/pay_insteads/data/models/update_pay_instead_model.dart';
import 'package:app/feature/pay_insteads/domain/repositories/pay_insteads_repository.dart';

class UpdatePayInsteadUsecase {
  Future<Either<Failure, PayInsteadModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    required ShowLoading showLoading,
    required UpdatePayInsteadModel model,
  }) async {
    return await sl<PayInsteadsRepositoryAbs>().update(
        model: model,
        id: model.id,
        showLoading: showLoading,
        source: dataSource,
        params: params,
        showMessage: showMessage);
  }
}
