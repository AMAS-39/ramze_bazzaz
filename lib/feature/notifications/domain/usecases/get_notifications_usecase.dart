import 'package:app/core/shared/imports.dart';
import 'package:app/feature/notifications/data/models/notifications_filter.dart';
import 'package:app/feature/notifications/data/models/notifications_model.dart';
import 'package:app/feature/notifications/domain/repositories/notifications_repository.dart';

class GetNotificationsUsecase {
  Future<Either<Failure, ReponseList<NotificationModel>>> call({
    required NotificationsFilterModel params,
    required MetaModel metaModel,
    ShowMessage showMessage = ShowMessage.none,
    DataSource dataSource = DataSource.remote,
  }) async {
    return await sl<NotificationsRepositoryAbs>().getAll(
        dataSource: dataSource,
        params: params,
        metaModel: metaModel,
        showMessage: showMessage);
  }
}
