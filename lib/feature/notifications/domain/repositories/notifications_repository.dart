import 'package:app/core/generics/generic_repository.dart';
import 'package:app/core/shared/imports.dart';
import 'package:app/feature/notifications/data/models/mark_all_as_read_model.dart';
import 'package:app/feature/notifications/data/models/mark_as_read_model.dart';
import 'package:app/feature/notifications/data/models/notification_detalis_model.dart';
import 'package:app/feature/notifications/data/models/notifications_filter.dart';
import 'package:app/feature/notifications/data/models/notifications_model.dart';

abstract class NotificationsRepositoryAbs
    implements
        GetOneGenericRepository<NotificationDetalisModel?, String>,
        DeleteGenericRepository<UnitModel?, String>,
        GetAllGenericRepository<NotificationModel, NotificationsFilterModel> {
  Future<Either<Failure, UnitModel?>> markAsRead({
    required Map<String, dynamic> params,
    required ShowMessage showMessage,
    required ShowLoading showLoading,
    required MarkNotificationAsReadModel model,
  });
  Future<Either<Failure, UnitModel?>> markAllAsRead({
    required ShowMessage showMessage,
    required ShowLoading showLoading,
    required MarkAllNotificationAsReadModel model,
    Map<String, String> params = const {},
  });
}
