import 'package:app/core/shared/imports.dart';
import 'package:app/feature/stock/data/datasources/stock_remote_data_source.dart';
import 'package:app/feature/stock/data/models/stock_item_model.dart';
import 'package:app/feature/stock/domain/repositories/stock_repository.dart';

class StockRepositoryImpl extends StockRepositoryAbs {
  final StockRemoteOperation remoteOperation;

  StockRepositoryImpl({required this.remoteOperation});

  @override
  Future<Either<Failure, List<StockItemModel>>> fetchStock({
    int? limit,
    String? search,
    DateTime? startDate,
    DateTime? endDate,
    int page = 0,
    int setNumber = 0,
    ShowMessage showMessage = ShowMessage.none,
    ShowLoading showLoading = ShowLoading.none,
  }) async {
    final queryParameters = <String, dynamic>{
      'page': page + 1,
      'setNumber': setNumber,
      'platform': 'mobile',
      'end': limit ?? 2000,
      if (limit != null) 'pageSize': limit,
      if (search != null && search.isNotEmpty) 'search': search,
      if (startDate != null) 'startDate': startDate.toIso8601String(),
      if (endDate != null) 'endDate': endDate.toIso8601String(),
    };
    return remoteOperation.getStock(
      queryParameters: queryParameters,
      showMessage: showMessage,
      showLoading: showLoading,
      name: Trans.stock.trans(),
    );
  }
}
