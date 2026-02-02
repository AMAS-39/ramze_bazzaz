import 'package:app/feature/payments/data/datasources/payments_remote_data_source.dart';
import 'package:app/feature/payments/data/repositories/payments_repository_impl.dart';
import 'package:app/feature/payments/domain/repositories/payments_repository.dart';
import 'package:app/feature/payments/domain/usecases/create_payment_usecase.dart';
import 'package:app/feature/payments/domain/usecases/delete_payment_usecase.dart';
import 'package:app/feature/payments/domain/usecases/get_payment_usecase.dart';
import 'package:app/feature/payments/domain/usecases/get_payments_usecase.dart';
import 'package:app/feature/payments/domain/usecases/update_payment_usecase.dart';
import 'package:app/feature/payments/presentation/blocs/all/payments_bloc.dart';
import 'package:app/injections.dart';

class PaymentFeature {
  static void init() {
    // //! Payment Feature
    sl.registerLazySingleton<PaymentsRemoteOperation>(
        () => PaymentsRemoteOperation(networkOperation: sl()));
    sl.registerLazySingleton<PaymentsRepositoryAbs>(
        () => PaymentsRepositoryImpl(networkOperation: sl()));

// //! UseCases
    sl.registerLazySingleton<GetPaymentUsecase>(() => GetPaymentUsecase());
    sl.registerLazySingleton<CreatePaymentUsecase>(
        () => CreatePaymentUsecase());
    sl.registerLazySingleton<DeletePaymentUsecase>(
        () => DeletePaymentUsecase());
    sl.registerLazySingleton<UpdatePaymentUsecase>(
        () => UpdatePaymentUsecase());
    sl.registerLazySingleton<GetPaymentsUsecase>(() => GetPaymentsUsecase());
    //!Bloc
    sl.registerLazySingleton<PaymentsBloc>(() => PaymentsBloc());
  }

  static void reInitBloc() {
    sl<PaymentsBloc>().add(const PaymentEmptyEvent());
  }
}
