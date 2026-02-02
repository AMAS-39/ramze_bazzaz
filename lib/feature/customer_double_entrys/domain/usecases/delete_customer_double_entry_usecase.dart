import 'package:app/core/shared/imports.dart';
import 'package:app/feature/customer_double_entrys/data/models/customer_double_entrys_model.dart';
import 'package:app/feature/customer_double_entrys/domain/repositories/customer_double_entrys_repository.dart';

class DeleteCustomerDoubleEntryUsecase {
  Future<Either<Failure, UnitModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    required ShowLoading showLoading,
    required CustomerDoubleEntryModel model,
  }) async {
    return await sl<CustomerDoubleEntrysRepositoryAbs>().delete(
        id: model.id,
        showLoading: showLoading,
        params: params,
        showMessage: showMessage);
  }
}
