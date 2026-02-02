import 'package:app/core/shared/imports.dart';
import 'package:app/feature/attachments/data/models/attachments_filter.dart';
import 'package:app/feature/attachments/presentation/blocs/all/attachments_bloc.dart';
import 'package:app/feature/attachments/presentation/view/widgets/attachment_widget.dart';
import 'package:app/feature/container_expenses/presentation/view/pages/sets_widget.dart';
import 'package:app/feature/loading_more/bloc/loading_more_bloc.dart';
import 'package:app/feature/loading_more/view/loading_more_widget.dart';
import 'package:app/widgets/status_widgets/export_status_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttachmentsScreen extends StatefulWidget {
  const AttachmentsScreen({super.key, required this.filterController});
  final AttachmentsFilterModel filterController;
  @override
  State<AttachmentsScreen> createState() => _AttachmentsScreenState();
}

class _AttachmentsScreenState extends State<AttachmentsScreen> {
  Future<void> _onRefresh(bool empty) async {
    packagesBloc.add(AttachmentLoadEvent(
        empty: empty, refresh: true, filters: packagesFilterModel));

    await packagesBloc.stream.first;
  }

  AttachmentsFilterModel packagesFilterModel =
      const AttachmentsFilterModel(setNumber: firstSet);
  @override
  void initState() {
    packagesFilterModel = widget.filterController;
    loadMoreBloc = LoadMoreBloc();
    super.initState();
    logger("initState");
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (packagesBloc.state.loadIsNot) {
        packagesBloc.add(AttachmentLoadEvent(filters: packagesFilterModel));
      }
    });
  }

  @override
  void dispose() {
    logger("dispose");
    super.dispose();
  }

  int length = 0;
  late LoadMoreBloc loadMoreBloc;
  AttachmentsBloc packagesBloc = AttachmentsBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => packagesBloc,
      child: Scaffold(
        appBar: appConfig.app == App.rbb
            ? null
            : AppBar(title: Text(Trans.attachments.trans())),
        body: Column(
          children: [
            BlocConsumer<AttachmentsBloc, AttachmentsState>(
              listener: (context, status) {},
              builder: (context, status) {
                if (status is AttachmentsLoadedState) {
                  final sta = status.metaModel;
                  length = sta.xTotalSets;
                }
                return SetsWidget(
                  selected: packagesFilterModel.setNumber,
                  maxLength: length,
                  onChange: (index) {
                    packagesFilterModel =
                        packagesFilterModel.copyWith(setNumber: index);
                    _onRefresh(true);
                  },
                );
              },
            ),
            BlocConsumer<AttachmentsBloc, AttachmentsState>(
                listener: (context, status) {},
                builder: (context, status) {
                  if (status is AttachmentsLoadingState ||
                      status is AttachmentInitialState) {
                    return const Expanded(child: LoadingWidget());
                  } else if (status is AttachmentsErrorState) {
                    return Expanded(
                      child: FailureScreen(
                          name: Trans.attachments.trans(),
                          failure: status.failure,
                          onRefresh: () => _onRefresh(false)),
                    );
                  } else if (status is AttachmentsEmptyState) {
                    return Expanded(
                      child: NoDataFound(
                          onRefresh: () => _onRefresh(false),
                          text: Trans.noDataFound.trans(
                              args: [Trans.attachments.trans()],
                              context: context)),
                    );
                  } else if (status is AttachmentsLoadedState) {
                    return Expanded(
                        child: NotificationListener<ScrollNotification>(
                      onNotification: _onNotification,
                      child: RefreshIndicator(
                        onRefresh: () => _onRefresh(false),
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return const Divider(height: 8);
                          },
                          shrinkWrap: false,
                          padding: const EdgeInsets.all(8),
                          physics: const AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          controller: scrollController,
                          itemCount: status.data.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == status.data.length) {
                              return LoadMoreWidget(loadMoreBloc: loadMoreBloc);
                            }
                            return AttachmentWidget(
                                attachment: status.data[index]);
                          },
                        ),
                      ),
                    ));
                  }
                  return const SizedBox.shrink();
                }),
          ],
        ),
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
        loadMoreBloc.add(const LoadingMoreEvent(
            status: LoadingMoreStatus(
                failure: null, pagination: Pagination.loading)));
        packagesBloc.add(AttachmentLoadEvent(
            onDone: (event) async {
              await Future.delayed(const Duration(seconds: 1));
              loadMoreBloc.add(event);
            },
            filters: packagesFilterModel));
      },
      metaModel: packagesBloc.state.metaModel,
    );
    return true;
  }
}
 