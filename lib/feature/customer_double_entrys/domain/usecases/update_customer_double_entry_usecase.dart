import 'package:app/core/shared/imports.dart';
import 'package:app/feature/customer_double_entrys/data/models/customer_double_entrys_model.dart';
import 'package:app/feature/customer_double_entrys/data/models/update_customer_double_entry_model.dart';
import 'package:app/feature/customer_double_entrys/domain/repositories/customer_double_entrys_repository.dart';

class UpdateCustomerDoubleEntryUsecase {
  Future<Either<Failure, CustomerDoubleEntryModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    required ShowLoading showLoading,
    required UpdateCustomerDoubleEntryModel model,
  }) async {
    return await sl<CustomerDoubleEntrysRepositoryAbs>().update(
        model: model,
        id: model.id,
        showLoading: showLoading,
        source: dataSource,
        params: params,
        showMessage: showMessage);
  }
}
