import 'package:app/core/shared/imports.dart';
import 'package:app/feature/pay_insteads/data/models/pay_insteads_filter.dart';
import 'package:app/feature/pay_insteads/data/models/pay_insteads_model.dart';
import 'package:app/feature/pay_insteads/domain/repositories/pay_insteads_repository.dart';

class GetPayInsteadsUsecase {
  Future<Either<Failure, ReponseList<PayInsteadModel>>> call({
    required PayInsteadsFilterModel params,
    required MetaModel metaModel,
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
  }) async {
    return await sl<PayInsteadsRepositoryAbs>().getAll(
        dataSource: dataSource,
        params: params,
        metaModel: metaModel,
        showMessage: showMessage);
  }
}
