import 'package:app/core/shared/imports.dart';
import 'package:app/feature/pay_insteads/data/models/create_pay_instead_model.dart';
import 'package:app/feature/pay_insteads/data/models/pay_insteads_model.dart';
import 'package:app/feature/pay_insteads/domain/repositories/pay_insteads_repository.dart';

class CreatePayInsteadUsecase {
  Future<Either<Failure, PayInsteadModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    required ShowLoading showLoading,
    required CreatePayInsteadModel model,
  }) async {
    return await sl<PayInsteadsRepositoryAbs>().create(
        model: model,
        showLoading: showLoading,
        dataSource: dataSource,
        params: params,
        showMessage: showMessage);
  }
}
