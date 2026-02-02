import 'package:app/core/shared/imports.dart';
import 'package:app/feature/pay_insteads/data/models/pay_instead_details_model.dart';
import 'package:app/feature/pay_insteads/domain/repositories/pay_insteads_repository.dart';

class GetPayInsteadUsecase {
  Future<Either<Failure, PayInsteadDetailsModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    required int id,
  }) async {
    return await sl<PayInsteadsRepositoryAbs>().getOne(
        id: id,
        dataSource: dataSource,
        params: params,
        showMessage: showMessage);
  }
}
