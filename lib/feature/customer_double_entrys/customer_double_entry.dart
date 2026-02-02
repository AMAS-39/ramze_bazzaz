import 'package:app/feature/customer_double_entrys/data/datasources/customer_double_entrys_remote_data_source.dart';
import 'package:app/feature/customer_double_entrys/data/repositories/customer_double_entrys_repository_impl.dart';
import 'package:app/feature/customer_double_entrys/domain/repositories/customer_double_entrys_repository.dart';
import 'package:app/feature/customer_double_entrys/domain/usecases/create_customer_double_entry_usecase.dart';
import 'package:app/feature/customer_double_entrys/domain/usecases/delete_customer_double_entry_usecase.dart';
import 'package:app/feature/customer_double_entrys/domain/usecases/get_customer_double_entry_usecase.dart';
import 'package:app/feature/customer_double_entrys/domain/usecases/get_customer_double_entrys_usecase.dart';
import 'package:app/feature/customer_double_entrys/domain/usecases/update_customer_double_entry_usecase.dart';
import 'package:app/feature/customer_double_entrys/presentation/blocs/all/customer_double_entrys_bloc.dart';
import 'package:app/injections.dart';

class CustomerDoubleEntryFeature {
  static void init() {
    // //! CustomerDoubleEntry Feature

    sl.registerLazySingleton<CustomerDoubleEntrysRemoteOperation>(
        () => CustomerDoubleEntrysRemoteOperation(networkOperation: sl()));
    sl.registerLazySingleton<CustomerDoubleEntrysRepositoryAbs>(
        () => CustomerDoubleEntrysRepositoryImpl(networkOperation: sl()));

// //! UseCases
    sl.registerLazySingleton<GetCustomerDoubleEntryUsecase>(
        () => GetCustomerDoubleEntryUsecase());
    sl.registerLazySingleton<CreateCustomerDoubleEntryUsecase>(
        () => CreateCustomerDoubleEntryUsecase());
    sl.registerLazySingleton<DeleteCustomerDoubleEntryUsecase>(
        () => DeleteCustomerDoubleEntryUsecase());
    sl.registerLazySingleton<UpdateCustomerDoubleEntryUsecase>(
        () => UpdateCustomerDoubleEntryUsecase());
    sl.registerLazySingleton<GetCustomerDoubleEntrysUsecase>(
        () => GetCustomerDoubleEntrysUsecase());
    //!Bloc
    sl.registerLazySingleton<CustomerDoubleEntrysBloc>(
        () => CustomerDoubleEntrysBloc());
  }

  static void reInitBloc() {
    sl<CustomerDoubleEntrysBloc>().add(const CustomerDoubleEntryEmptyEvent());
  }
}
