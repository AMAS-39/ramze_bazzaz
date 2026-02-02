import 'package:app/core/shared/imports.dart';
import 'package:app/feature/notifications/data/models/notifications_model.dart';
import 'package:app/feature/notifications/domain/repositories/notifications_repository.dart';

class DeleteNotificationUsecase {
  Future<Either<Failure, UnitModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
    required ShowLoading showLoading,
    required NotificationModel model,
  }) async {
    return await sl<NotificationsRepositoryAbs>().delete(
        id: model.id,
        showLoading: showLoading,
        params: params,
        showMessage: showMessage);
  }
}
