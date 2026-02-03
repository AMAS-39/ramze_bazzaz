import 'package:app/feature/account/data/repo/account_repo.dart';
import 'package:app/feature/reports/data/datasources/reports_remote_data_source.dart';
import 'package:app/feature/reports/data/repositories/reports_repository_impl.dart';
import 'package:app/feature/reports/domain/repositories/reports_repository.dart';
import 'package:app/injections.dart';

class ReportsFeature {
  static void init() {
    sl.registerLazySingleton<ReportsRemoteDataSource>(
      () => ReportsRemoteDataSource(),
    );
    sl.registerLazySingleton<ReportsRepository>(
      () => ReportsRepositoryImpl(
        remote: sl(),
        accountRepo: sl(),
      ),
    );
  }
}
