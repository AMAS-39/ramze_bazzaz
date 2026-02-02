import 'package:app/core/shared/imports.dart';
import 'package:app/feature/customer_double_entrys/data/models/customer_double_entrys_filter.dart';
import 'package:app/feature/customer_double_entrys/data/models/customer_double_entrys_model.dart';
import 'package:app/feature/customer_double_entrys/domain/repositories/customer_double_entrys_repository.dart';

class GetCustomerDoubleEntrysUsecase {
  Future<Either<Failure, ReponseList<CustomerDoubleEntryModel>>> call({
    required CustomerDoubleEntrysFilterModel params,
    required MetaModel metaModel,
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    ShowLoading showLoading = ShowLoading.none,
  }) async {
    return await sl<CustomerDoubleEntrysRepositoryAbs>().getAll(
        showLoading: showLoading,
        dataSource: dataSource,
        params: params,
        metaModel: metaModel,
        showMessage: showMessage);
  }
}
