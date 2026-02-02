import 'package:app/core/shared/imports.dart';
import 'package:app/feature/loading_more/bloc/loading_more_bloc.dart';
import 'package:app/feature/loading_more/view/loading_more_widget.dart';
import 'package:app/feature/notifications/data/models/notifications_filter.dart';
import 'package:app/feature/notifications/presentation/blocs/all/notifications_bloc.dart';
import 'package:app/feature/notifications/presentation/view/widgets/notification_widget.dart';
import 'package:app/widgets/status_widgets/export_status_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key, required this.filterController});
  final NotificationsFilterModel filterController;
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  Future<void> _onRefresh() async {
    sl<NotificationsBloc>().add(
        NotificationLoadEvent(refresh: true, filters: widget.filterController));

    await sl<NotificationsBloc>().stream.first;
  }

  @override
  void initState() {
    loadMoreBloc = LoadMoreBloc();
    super.initState();
    logger("initState");
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (sl<NotificationsBloc>().state.loadIsNot) {
        sl<NotificationsBloc>()
            .add(NotificationLoadEvent(filters: widget.filterController));
      }
    });
  }

  @override
  void dispose() {
    logger("dispose");
    super.dispose();
  }

  late LoadMoreBloc loadMoreBloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   PopupMenuButton<int>(
        //     onSelected: (int item) {
        //       if (item == 0) {
        //         sl<NotificationsBloc>().add(const NotificationMarkAllEvent(
        //             model: MarkAllNotificationAsReadModel()));
        //       }
        //     },
        //     itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        //       PopupMenuItem<int>(
        //         value: 0,
        //         child: Text(Trans.markAllAsRead.trans(),
        //             style: context.style14W400B),
        //       ),
        //     ],
        //   ),
        // ],
        // elevation: 0,
        title: Text(Trans.notifications.trans()),
      ),
      body: BlocProvider(
        create: (context) => loadMoreBloc,
        child: BlocConsumer<NotificationsBloc, NotificationsState>(
            listener: (context, status) {},
            builder: (context, status) {
              if (status is NotificationsLoadingState ||
                  status is NotificationInitialState) {
                return const LoadingWidget();
              } else if (status is NotificationsErrorState) {
                return FailureScreen(
                    name: Trans.notifications.trans(),
                    failure: status.failure,
                    onRefresh: _onRefresh);
              } else if (status is NotificationsEmptyState) {
                return NoDataFound(
                    onRefresh: _onRefresh,
                    text: Trans.noDataFound.trans(
                        args: [Trans.notifications.trans()], context: context));
              } else if (status is NotificationsLoadedState) {
                return Column(
                  children: [
                    Expanded(
                        child: NotificationListener<ScrollNotification>(
                      onNotification: _onNotification,
                      child: RefreshIndicator(
                        onRefresh: _onRefresh,
                        child: ListView.separated(
                          shrinkWrap: false,
                          padding: EdgeInsets.zero,
                          separatorBuilder: (context, index) {
                            return const Divider(
                              endIndent: 20,
                              indent: 20,
                            );
                          },
                          physics: const AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          controller: scrollController,
                          itemCount: status.data.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == status.data.length) {
                              return LoadMoreWidget(loadMoreBloc: loadMoreBloc);
                            }
                            return NotificationWidget(
                                notification: status.data[index]);
                          },
                        ),
                      ),
                    )),
                  ],
                );
              }
              return const SizedBox.shrink();
            }),
      ),
    );
  }

  ScrollController scrollController = ScrollController();
  bool _onNotification(ScrollNotification scrollNotification) {
    onScroll(
      notification: scrollNotification,
      loadMoreBloc: loadMoreBloc,
      scrollController: scrollController,
      onLoad: () {
        sl<NotificationsBloc>().add(NotificationLoadEvent(
            onDone: (event) async {
              await Future.delayed(const Duration(seconds: 1));
              loadMoreBloc.add(event);
            },
            filters: widget.filterController));
      },
      metaModel: sl<NotificationsBloc>().state.metaModel,
    );
    return true;
  }
}
