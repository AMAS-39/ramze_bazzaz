import 'package:app/feature/containers/data/datasources/containers_remote_data_source.dart';
import 'package:app/feature/containers/data/repositories/containers_repository_impl.dart';
import 'package:app/feature/containers/domain/repositories/containers_repository.dart';
import 'package:app/feature/containers/domain/usecases/create_container_usecase.dart';
import 'package:app/feature/containers/domain/usecases/delete_container_usecase.dart';
import 'package:app/feature/containers/domain/usecases/get_container_usecase.dart';
import 'package:app/feature/containers/domain/usecases/get_containers_usecase.dart';
import 'package:app/feature/containers/domain/usecases/update_container_usecase.dart';
import 'package:app/feature/containers/presentation/blocs/all/containers_bloc.dart';
import 'package:app/injections.dart';

class ContainerFeature {
  static void init() {
    // //! Container Feature
    sl.registerLazySingleton<ContainersRemoteOperation>(
        () => ContainersRemoteOperation(networkOperation: sl()));
    sl.registerLazySingleton<ContainersRepositoryAbs>(
        () => ContainersRepositoryImpl(networkOperation: sl()));

// //! UseCases
    sl.registerLazySingleton<GetContainerUsecase>(() => GetContainerUsecase());
    sl.registerLazySingleton<CreateContainerUsecase>(
        () => CreateContainerUsecase());
    sl.registerLazySingleton<DeleteContainerUsecase>(
        () => DeleteContainerUsecase());
    sl.registerLazySingleton<UpdateContainerUsecase>(
        () => UpdateContainerUsecase());
    sl.registerLazySingleton<GetContainersUsecase>(
        () => GetContainersUsecase());
    //!Bloc
    sl.registerLazySingleton<ContainersBloc>(() => ContainersBloc());
  }

  static void reInitBloc() {
    sl<ContainersBloc>().add(const ContainerEmptyEvent());
  }
}
