import 'package:app/core/shared/imports.dart';
import 'package:app/feature/loading_more/bloc/loading_more_bloc.dart';
import 'package:app/feature/notifications/data/models/mark_all_as_read_model.dart';
import 'package:app/feature/notifications/data/models/mark_as_read_model.dart';
import 'package:app/feature/notifications/data/models/notifications_filter.dart';
import 'package:app/feature/notifications/data/models/notifications_model.dart';
import 'package:app/feature/notifications/domain/usecases/delete_notification_usecase.dart';
import 'package:app/feature/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:app/feature/notifications/domain/usecases/mark_all_as_read_notifications_usecase.dart';
import 'package:app/feature/notifications/domain/usecases/mark_as_read_notification_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationEvent, NotificationsState> {
  final GetNotificationsUsecase repository;
  NotificationsBloc({required this.repository})
      : super(NotificationInitialState()) {
    on<NotificationLoadEvent>(_onLoadNotificationEvent);
    on<NotificationEmptyEvent>(_onNotificationEmptyEvent);
    on<NotificationDeleteEvent>(_onNotificationDeleteEvent);
    on<NotificationMarkOneEvent>(_onNotificationCreateEvent);
    on<NotificationMarkAllEvent>(_onNotificationUpdateEvent);
  }
  Future<void> _onNotificationEmptyEvent(
      NotificationEmptyEvent event, Emitter<NotificationsState> emit) async {
    emit(NotificationInitialState());
  }

  Future<void> _onNotificationDeleteEvent(
      NotificationDeleteEvent event, Emitter<NotificationsState> emit) async {
    final isDeleted = await DeleteNotificationUsecase().call(
        showMessage: ShowMessage.bothToast,
        showLoading: ShowLoading.show,
        model: event.model);
    if (isDeleted.isRight()) {
      emit(NotificationsLoadedState(
          data: state.items
              .where((element) => element.id != event.model.id)
              .toList(),
          metaModel: state.metaModel));
    }
  }

  Future<void> _onNotificationUpdateEvent(
      NotificationMarkAllEvent event, Emitter<NotificationsState> emit) async {
    final result = await MarkAllAsReadNotificationUsecase().call(
        showMessage: ShowMessage.bothToast,
        showLoading: ShowLoading.show,
        model: event.model);
    if (result.isRight()) {
      final newData = state.items
          .map((element) => element.copyWith(readAt: DateTime.now()))
          .toList();
      emit(NotificationsLoadedState(data: newData, metaModel: state.metaModel));
    }
  }

  Future<void> _onNotificationCreateEvent(
      NotificationMarkOneEvent event, Emitter<NotificationsState> emit) async {
    final result = await MarkNotificationUsecase().call(
        showMessage: ShowMessage.none,
        showLoading: ShowLoading.none,
        model: event.model);
    if (result.isRight()) {
      final newData = state.items.map((element) {
        if (element.id == event.model.id) {
          return element.copyWith(readAt: DateTime.now());
        } else {
          return element;
        }
      }).toList();
      emit(NotificationsLoadedState(data: [
        ...newData,
      ], metaModel: state.metaModel));
    }
  }

  Future<void> _onLoadNotificationEvent(
      NotificationLoadEvent event, Emitter<NotificationsState> eimter) async {
    if (state.loadIsNot || event.empty) {
      eimter(NotificationsLoadingState());
    }
    final result = await repository.call(
        metaModel: state.metaModel
            .copyWith(page: currentPage(event.refresh, state.metaModel)),
        params: event.filters,
        showMessage: event.showMessage,
        dataSource: event.dataSource);
    result.fold(
      (failure) {
        if (state is! NotificationsLoadedState) {
          eimter(NotificationsErrorState(failure: failure));
        }
        event.onDone?.call(LoadingMoreEvent(
            status: LoadingMoreStatus(
                failure: failure, pagination: Pagination.error)));
      },
      (data) {
        event.onDone?.call(const LoadingMoreEvent(
            status: LoadingMoreStatus(pagination: Pagination.notMatch)));
        eimter(_mapPropsToState(
            data, currentPage(event.refresh, state.metaModel)));
      },
    );
    logger(state);
  }

  NotificationsState _mapPropsToState(
      ReponseList<NotificationModel>? data, int page) {
    if (data == null) {
      return state;
    }
    return data.data.isEmpty && state is! NotificationsLoadedState
        ? const NotificationsEmptyState()
        : NotificationsLoadedState(
            metaModel: compineMeta(state.metaModel, data.meta),
            data: [if (page != firstPage) ...state.items, ...data.data]);
  }
}
