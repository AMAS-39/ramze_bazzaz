import 'package:app/core/shared/imports.dart';
import 'package:app/feature/notifications/data/models/notification_detalis_model.dart';
import 'package:app/feature/notifications/domain/usecases/get_notification_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class OneNotificationsBloc
    extends Bloc<OneNotificationEvent, OneNotificationState> {
  final GetNotificationUsecase repository = sl<GetNotificationUsecase>();
  OneNotificationsBloc() : super(OneNotificationInitialState()) {
    on<OneNotificationGetEvent>(oneNotificationGetEvent);
  }
  Future<Either<Failure, NotificationDetalisModel?>> oneNotificationGetEvent(OneNotificationGetEvent event,
      Emitter<OneNotificationState> emiter) async {
    emiter(OneNotificationLoadingState());

    final result = await repository.call(
        params: {},
        id: event.id,
        showMessage: event.showMessage,
        dataSource: event.dataSource);
    logger(result);
    result.fold((failure) {
      if (state is! OneNotificationLoadedState) {
        emiter(OneNotificationErrorState(failure: failure));
      } else if (state is OneNotificationLoadedState) {
        emiter(OneNotificationLoadedState(
            data: (state as OneNotificationLoadedState).data,
            failure: failure
              ..error.copyWith(message: Trans.canotRefreshPage.trans())));
      }
    }, (data) => emiter(_mapPropsToState(data)));
    logger("state $state");
    return result;
  }

  OneNotificationState _mapPropsToState(
      NotificationDetalisModel? notification) {
    return notification == null
        ? const OneNotificationEmptyState()
        : OneNotificationLoadedState(failure: null, data: notification);
  }
}
