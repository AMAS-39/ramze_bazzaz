import 'package:app/feature/packages/data/datasources/packages_remote_data_source.dart';
import 'package:app/feature/packages/data/repositories/packages_repository_impl.dart';
import 'package:app/feature/packages/domain/repositories/packages_repository.dart';
import 'package:app/feature/packages/domain/usecases/create_package_usecase.dart';
import 'package:app/feature/packages/domain/usecases/delete_package_usecase.dart';
import 'package:app/feature/packages/domain/usecases/get_package_usecase.dart';
import 'package:app/feature/packages/domain/usecases/get_packages_usecase.dart';
import 'package:app/feature/packages/domain/usecases/update_package_usecase.dart';
import 'package:app/feature/packages/presentation/blocs/all/packages_bloc.dart';
import 'package:app/injections.dart';

class PackageFeature {
  static void init() {
    // //! Package Feature
    sl.registerLazySingleton<PackagesRemoteOperation>(
        () => PackagesRemoteOperation(networkOperation: sl()));
    sl.registerLazySingleton<PackagesRepositoryAbs>(
        () => PackagesRepositoryImpl(networkOperation: sl()));

// //! UseCases
    sl.registerLazySingleton<GetPackageUsecase>(() => GetPackageUsecase());
    sl.registerLazySingleton<CreatePackageUsecase>(
        () => CreatePackageUsecase());
    sl.registerLazySingleton<DeletePackageUsecase>(
        () => DeletePackageUsecase());
    sl.registerLazySingleton<UpdatePackageUsecase>(
        () => UpdatePackageUsecase());
    sl.registerLazySingleton<GetPackagesUsecase>(() => GetPackagesUsecase());
    //!Bloc
    sl.registerLazySingleton<PackagesBloc>(() => PackagesBloc());
  }

  static void reInitBloc() {
    sl<PackagesBloc>().add(const PackageEmptyEvent());
  }
}
