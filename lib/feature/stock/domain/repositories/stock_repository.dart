import 'package:app/core/shared/imports.dart';
import 'package:app/feature/stock/data/models/stock_item_model.dart';

abstract class StockRepositoryAbs {
  Future<Either<Failure, List<StockItemModel>>> fetchStock({
    int? limit,
    String? search,
    DateTime? startDate,
    DateTime? endDate,
    int page = 0,
    int setNumber = 0,
    ShowMessage showMessage = ShowMessage.none,
    ShowLoading showLoading = ShowLoading.none,
  });
}
