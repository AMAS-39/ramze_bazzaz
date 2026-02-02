import 'package:app/core/shared/imports.dart';
import 'package:app/feature/customer_double_entrys/data/models/customer_double_entry_details_model.dart';
import 'package:app/feature/customer_double_entrys/domain/repositories/customer_double_entrys_repository.dart';

class GetCustomerDoubleEntryUsecase {
  Future<Either<Failure, CustomerDoubleEntryDetailsModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    ShowLoading showLoading = ShowLoading.none,
    required int id,
  }) async {
    return await sl<CustomerDoubleEntrysRepositoryAbs>().getOne(
        id: id,
        showLoading: showLoading,
        dataSource: dataSource,
        params: params,
        showMessage: showMessage);
  }
}
