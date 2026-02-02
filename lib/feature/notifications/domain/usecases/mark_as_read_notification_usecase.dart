import 'package:app/core/shared/imports.dart';
import 'package:app/feature/notifications/data/models/mark_as_read_model.dart';
import 'package:app/feature/notifications/domain/repositories/notifications_repository.dart';

class MarkNotificationUsecase {
  Future<Either<Failure, UnitModel?>> call({
    Map<String, String> params = const {},
    ShowMessage showMessage = ShowMessage.none,
    required ShowLoading showLoading,
    required MarkNotificationAsReadModel model,
  }) async {
    return await sl<NotificationsRepositoryAbs>().markAsRead(
        model: model,
        showLoading: showLoading,
        params: params,
        showMessage: showMessage);
  }
}
