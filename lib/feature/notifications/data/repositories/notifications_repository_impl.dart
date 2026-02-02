import 'package:app/core/shared/imports.dart';
import 'package:app/feature/notifications/data/datasources/notifications_remote_data_source.dart';
import 'package:app/feature/notifications/data/models/mark_all_as_read_model.dart';
import 'package:app/feature/notifications/data/models/mark_as_read_model.dart';
import 'package:app/feature/notifications/data/models/notification_detalis_model.dart';
import 'package:app/feature/notifications/data/models/notifications_filter.dart';
import 'package:app/feature/notifications/data/models/notifications_model.dart';
import 'package:app/feature/notifications/domain/repositories/notifications_repository.dart';

class NotificationsRepositoryImpl extends NotificationsRepositoryAbs {
  final NotificationsRemoteOperation networkOperation;

  NotificationsRepositoryImpl({
    required this.networkOperation,
  });

  @override
  Future<Either<Failure, NotificationDetalisModel?>> getOne(
      {required dynamic id,
      required ShowMessage showMessage,
      int popupTimes = 0,
      ShowLoading showLoading = ShowLoading.none,
      required DataSource dataSource,
      Map<String, String> params = const {}}) async {
    final res = await networkOperation.getOne(
        recordId: id, params: params, showMessage: showMessage);

    return res;
  }

  @override
  Future<Either<Failure, ReponseList<NotificationModel>>> getAll(
      {required NotificationsFilterModel params,
      required ShowMessage showMessage,
      required DataSource dataSource,
      ShowLoading showLoading = ShowLoading.none,
      required MetaModel metaModel}) async {
    final result = await networkOperation.getNotifications(
      notificationFilterModel: params,
      metaModel: metaModel,
      params: params.toMap(),
      showMessage: showMessage,
    );

    return result;
  }

  @override
  Future<Either<Failure, UnitModel?>> markAsRead(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      required ShowLoading showLoading,
      required MarkNotificationAsReadModel model}) async {
    final res = await networkOperation.markAsRead(
        showLoading: showLoading,
        params: params,
        showMessage: showMessage,
        model: model);

    return res;
  }

  @override
  Future<Either<Failure, UnitModel?>> delete(
      {required String id,
      required Map<String, dynamic> params,
      required ShowMessage showMessage,
      required ShowLoading showLoading}) async {
    final res = await networkOperation.delete(
        params: params,
        showMessage: showMessage,
        showLoading: showLoading,
        id: id);

    return res;
  }

  @override
  Future<Either<Failure, UnitModel?>> markAllAsRead(
      {required ShowMessage showMessage,
      required ShowLoading showLoading,
      required MarkAllNotificationAsReadModel model,
      Map<String, String> params = const {}}) async {
    final res = await networkOperation.markAllAsRead(
        params: params,
        showMessage: showMessage,
        showLoading: showLoading,
        model: model);

    return res;
  }
}
