import 'package:app/feature/pay_insteads/data/datasources/pay_insteads_remote_data_source.dart';
import 'package:app/feature/pay_insteads/data/repositories/pay_insteads_repository_impl.dart';
import 'package:app/feature/pay_insteads/domain/repositories/pay_insteads_repository.dart';
import 'package:app/feature/pay_insteads/domain/usecases/create_pay_instead_usecase.dart';
import 'package:app/feature/pay_insteads/domain/usecases/delete_pay_instead_usecase.dart';
import 'package:app/feature/pay_insteads/domain/usecases/get_pay_instead_usecase.dart';
import 'package:app/feature/pay_insteads/domain/usecases/get_pay_insteads_usecase.dart';
import 'package:app/feature/pay_insteads/domain/usecases/update_pay_instead_usecase.dart';
import 'package:app/feature/pay_insteads/presentation/blocs/all/pay_insteads_bloc.dart';
import 'package:app/injections.dart';

class PayInsteadFeature {
  static void init() {
    // //! PayInstead Feature
    sl.registerLazySingleton<PayInsteadsRemoteOperation>(
        () => PayInsteadsRemoteOperation(networkOperation: sl()));
    sl.registerLazySingleton<PayInsteadsRepositoryAbs>(
        () => PayInsteadsRepositoryImpl(networkOperation: sl()));

// //! UseCases
    sl.registerLazySingleton<GetPayInsteadUsecase>(
        () => GetPayInsteadUsecase());
    sl.registerLazySingleton<CreatePayInsteadUsecase>(
        () => CreatePayInsteadUsecase());
    sl.registerLazySingleton<DeletePayInsteadUsecase>(
        () => DeletePayInsteadUsecase());
    sl.registerLazySingleton<UpdatePayInsteadUsecase>(
        () => UpdatePayInsteadUsecase());
    sl.registerLazySingleton<GetPayInsteadsUsecase>(
        () => GetPayInsteadsUsecase());
    //!Bloc
    sl.registerLazySingleton<PayInsteadsBloc>(() => PayInsteadsBloc());
    sl.registerLazySingleton<PayReturnBloc>(() => PayReturnBloc());
  }

  static void reInitBloc() {
    sl<PayInsteadsBloc>().add(const PayInsteadEmptyEvent());
    sl<PayReturnBloc>().add(const PayInsteadEmptyEvent());
  }
}
