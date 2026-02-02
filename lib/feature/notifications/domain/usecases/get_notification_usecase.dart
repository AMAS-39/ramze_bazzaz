import 'package:app/core/shared/imports.dart';
import 'package:app/feature/notifications/data/models/notification_detalis_model.dart';
import 'package:app/feature/notifications/domain/repositories/notifications_repository.dart';

class GetNotificationUsecase {
  Future<Either<Failure, NotificationDetalisModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    required String id,
  }) async {
    return await sl<NotificationsRepositoryAbs>().getOne(
        id: id,
        dataSource: dataSource,
        params: params,
        showMessage: showMessage);
  }
}
