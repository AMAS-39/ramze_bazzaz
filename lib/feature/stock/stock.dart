import 'package:app/feature/stock/data/datasources/stock_remote_data_source.dart';
import 'package:app/feature/stock/data/repositories/stock_repository_impl.dart';
import 'package:app/feature/stock/domain/repositories/stock_repository.dart';
import 'package:app/injections.dart';

class StockFeature {
  static void init() {
    sl.registerLazySingleton<StockRemoteOperation>(
      () => StockRemoteOperation(),
    );
    sl.registerLazySingleton<StockRepositoryAbs>(
      () => StockRepositoryImpl(remoteOperation: sl()),
    );
  }
}
