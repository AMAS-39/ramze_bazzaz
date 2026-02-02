import 'package:app/core/shared/imports.dart';
import 'package:app/feature/notifications/presentation/blocs/all/notifications_bloc.dart';
import 'package:app/feature/notifications/presentation/blocs/view_one/notification_bloc.dart';
import 'package:app/feature/notifications/presentation/view/widgets/notification_detalis_widget.dart';
import 'package:app/widgets/status_widgets/export_status_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationDetalisScreen extends StatefulWidget {
  const NotificationDetalisScreen(
      {super.key, required this.id, required this.name});
  final String id;
  final String name;

  @override
  State<NotificationDetalisScreen> createState() =>
      _NotificationDetalisScreenState();
}

class _NotificationDetalisScreenState extends State<NotificationDetalisScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      oneNotificationsBloc.add(OneNotificationGetEvent(id: widget.id));
    });
    super.initState();
  }

  OneNotificationsBloc oneNotificationsBloc = OneNotificationsBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => oneNotificationsBloc,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.name)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: BlocConsumer<OneNotificationsBloc, OneNotificationState>(
                    listener: (context, status) {
              if (status is OneNotificationLoadedState &&
                  (status).failure != null) {
                showFailedFlashBar(status.failure!.error.reason);
              }
              logger("status $status");
            }, builder: (context, status) {
              if (status is OneNotificationLoadingState ||
                  status is OneNotificationInitialState) {
                return const LoadingWidget();
              } else if (status is OneNotificationErrorState) {
                return FailureScreen(
                    name: Trans.notifications.trans(),
                    failure: status.failure,
                    onRefresh: _onRefresh);
              } else if (status is NotificationsEmptyState) {
                return NoDataFound(
                    onRefresh: _onRefresh,
                    text: Trans.noDataFound.trans(
                        args: [Trans.notifications.trans()], context: context));
              } else if (status is OneNotificationLoadedState) {
                return Column(children: [
                  Expanded(
                      child: RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: NotificationDetalisWidget(notification: status.data),
                  ))
                ]);
              }
              return const SizedBox.shrink();
            })),
          ],
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    oneNotificationsBloc.add(OneNotificationGetEvent(id: widget.id));
    await oneNotificationsBloc.stream.first;
  }
}
