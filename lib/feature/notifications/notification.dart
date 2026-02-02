import 'package:app/feature/notifications/data/datasources/notifications_remote_data_source.dart';
import 'package:app/feature/notifications/data/repositories/notifications_repository_impl.dart';
import 'package:app/feature/notifications/domain/repositories/notifications_repository.dart';
import 'package:app/feature/notifications/domain/usecases/delete_notification_usecase.dart';
import 'package:app/feature/notifications/domain/usecases/get_notification_usecase.dart';
import 'package:app/feature/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:app/feature/notifications/domain/usecases/mark_all_as_read_notifications_usecase.dart';
import 'package:app/feature/notifications/domain/usecases/mark_as_read_notification_usecase.dart';
import 'package:app/feature/notifications/presentation/blocs/all/notifications_bloc.dart';
import 'package:app/injections.dart';

class NotificationFeature {
  static void init() {
    // //! Notification Feature
    sl.registerLazySingleton<NotificationsRemoteOperation>(
        () => NotificationsRemoteOperation(networkOperation: sl()));
    sl.registerLazySingleton<NotificationsRepositoryAbs>(
        () => NotificationsRepositoryImpl(networkOperation: sl()));

//! UseCases
    sl.registerLazySingleton<GetNotificationUsecase>(
        () => GetNotificationUsecase());
    sl.registerLazySingleton<MarkNotificationUsecase>(
        () => MarkNotificationUsecase());
    sl.registerLazySingleton<DeleteNotificationUsecase>(
        () => DeleteNotificationUsecase());
    sl.registerLazySingleton<MarkAllAsReadNotificationUsecase>(
        () => MarkAllAsReadNotificationUsecase());
    sl.registerLazySingleton<GetNotificationsUsecase>(
        () => GetNotificationsUsecase());
    //!Bloc
    sl.registerLazySingleton<NotificationsBloc>(
        () => NotificationsBloc(repository: sl()));
  }

  static void reInitBloc() {
    sl<NotificationsBloc>().add(const NotificationEmptyEvent());
  }
}
