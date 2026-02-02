import 'package:app/core/data_source/remote_data_source/remote_data_source_abs.dart';
import 'package:app/core/shared/imports.dart';
import 'package:app/feature/notifications/data/models/mark_all_as_read_model.dart';
import 'package:app/feature/notifications/data/models/mark_as_read_model.dart';
import 'package:app/feature/notifications/data/models/notification_detalis_model.dart';
import 'package:app/feature/notifications/data/models/notifications_filter.dart';
import 'package:app/feature/notifications/data/models/notifications_model.dart';

class NotificationsRemoteOperation {
  late RemoteDataSourceAbs networkOperation;

  NotificationsRemoteOperation({required this.networkOperation});
  final String _names = Trans.notifications;

  Future<Either<Failure, ReponseList<NotificationModel>>> getNotifications({
    required Map<String, dynamic> params,
    required MetaModel metaModel,
    required NotificationsFilterModel notificationFilterModel,
    required ShowMessage showMessage,
  }) async {
    return await networkOperation.getData<NotificationModel>(
      fromJsonModel: NotificationModel.fromMap,
      endPoint: EndPoints.notifications,
      parseBody: ParseBody.data,
      queryParameters: {...params, ...metaModel.toMap()},
      name: _names,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, NotificationDetalisModel?>> getOne(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      required int recordId}) async {
    return await networkOperation.getOne<NotificationDetalisModel>(
      fromJsonModel: NotificationDetalisModel.fromMap,
      endPoint: "${EndPoints.notifications}/$recordId",
      queryParameters: params,
      name: Trans.notification.trans(),
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, UnitModel?>> markAsRead(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      required ShowLoading showLoading,
      required MarkNotificationAsReadModel model}) async {
    return await networkOperation.create<UnitModel>(
      fromJsonModel: UnitModel.fromMap,
      endPoint: EndPoints.markAsRead,
      queryParameters: params,
      body: model.toMap(),
      showLoading: showLoading,
      errorMsg: Trans.failedToMarkNotificationAsRead.trans(),
      successMsg: Trans.successfullyMarkNotificationAsRead.trans(),
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, UnitModel?>> markAllAsRead(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      required ShowLoading showLoading,
      required MarkAllNotificationAsReadModel model}) async {
    return await networkOperation.create<UnitModel>(
      fromJsonModel: UnitModel.fromMap,
      endPoint: EndPoints.markAllAsRead,
      queryParameters: params,
      errorMsg: Trans.failedToMarkAllNotificationsAsRead.trans(),
      successMsg: Trans.successfullyMarkAllNotificationsAsRead.trans(),
      isForm: false,
      showLoading: showLoading,
      body: model.toMap(),
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, UnitModel?>> delete(
      {required Map<String, dynamic> params,
      required ShowMessage showMessage,
      required ShowLoading showLoading,
      required String id}) async {
    return await networkOperation.delete<UnitModel>(
      fromJsonModel: UnitModel.fromMap,
      endPoint: "${EndPoints.notifications}/$id",
      queryParameters: params,
      name: Trans.notification.trans(),
      showLoading: showLoading,
      showMessage: showMessage,
    );
  }
}
