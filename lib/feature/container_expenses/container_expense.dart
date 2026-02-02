import 'package:app/feature/container_expenses/data/datasources/container_expenses_remote_data_source.dart';
import 'package:app/feature/container_expenses/data/repositories/container_expenses_repository_impl.dart';
import 'package:app/feature/container_expenses/domain/repositories/container_expenses_repository.dart';
import 'package:app/feature/container_expenses/domain/usecases/create_container_expense_usecase.dart';
import 'package:app/feature/container_expenses/domain/usecases/update_container_expense_usecase.dart';
import 'package:app/feature/container_expenses/domain/usecases/delete_container_expense_usecase.dart';
import 'package:app/feature/container_expenses/domain/usecases/get_container_expense_usecase.dart';
import 'package:app/feature/container_expenses/domain/usecases/get_container_expenses_usecase.dart';
import 'package:app/feature/container_expenses/presentation/blocs/all/container_expenses_bloc.dart';
import 'package:app/injections.dart';






class ContainerExpenseFeature {
  static void init() {  // //! ContainerExpense Feature
  sl.registerLazySingleton<ContainerExpensesRemoteOperation>(
      () => ContainerExpensesRemoteOperation(networkOperation: sl()));
  sl.registerLazySingleton<ContainerExpensesRepositoryAbs>(() => ContainerExpensesRepositoryImpl(
     networkOperation: sl()));


// //! UseCases
  sl.registerLazySingleton<GetContainerExpenseUsecase>(() => GetContainerExpenseUsecase());
  sl.registerLazySingleton<CreateContainerExpenseUsecase>(() => CreateContainerExpenseUsecase());
  sl.registerLazySingleton<DeleteContainerExpenseUsecase>(() => DeleteContainerExpenseUsecase());
  sl.registerLazySingleton<UpdateContainerExpenseUsecase>(() => UpdateContainerExpenseUsecase());
  sl.registerLazySingleton<GetContainerExpensesUsecase>(() => GetContainerExpensesUsecase());
  //!Bloc
  sl.registerLazySingleton<ContainerExpensesBloc>(() => ContainerExpensesBloc());
  
  }    static void reInitBloc() {
    sl<ContainerExpensesBloc>().add(const ContainerExpenseEmptyEvent());
  }}