import 'package:app/core/shared/imports.dart';
import 'package:app/feature/containers/data/models/containers_filter.dart';
import 'package:app/feature/containers/presentation/blocs/all/containers_bloc.dart';
import 'package:app/feature/containers/presentation/view/widgets/container_widget.dart';
import 'package:app/feature/loading_more/bloc/loading_more_bloc.dart';
import 'package:app/feature/loading_more/view/loading_more_widget.dart';
import 'package:app/widgets/status_widgets/export_status_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContainersScreen extends StatefulWidget {
  const ContainersScreen({super.key, required this.filterController});
  final ContainersFilterModel filterController;
  @override
  State<ContainersScreen> createState() => _ContainersScreenState();
}

class _ContainersScreenState extends State<ContainersScreen> {
  Future<void> _onRefresh() async {
    sl<ContainersBloc>().add(
        ContainerLoadEvent(refresh: true, filters: widget.filterController));

    await sl<ContainersBloc>().stream.first;
  }

  @override
  void initState() {
    loadMoreBloc = LoadMoreBloc();
    super.initState();
    logger("initState");
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (sl<ContainersBloc>().state.loadIsNot) {
        sl<ContainersBloc>()
            .add(ContainerLoadEvent(filters: widget.filterController));
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
      appBar: AppBar(title: Text(Trans.containers.trans())),
      body: BlocConsumer<ContainersBloc, ContainersState>(
          listener: (context, status) {},
          builder: (context, status) {
            if (status is ContainersLoadingState ||
                status is ContainerInitialState) {
              return const LoadingWidget();
            } else if (status is ContainersErrorState) {
              return FailureScreen(
                  name: Trans.containers.trans(),
                  failure: status.failure,
                  onRefresh: _onRefresh);
            } else if (status is ContainersEmptyState) {
              return NoDataFound(
                  onRefresh: _onRefresh,
                  text: Trans.noDataFound.trans(
                      args: [Trans.containers.trans()], context: context));
            } else if (status is ContainersLoadedState) {
              return Column(
                children: [
                  Expanded(
                      child: NotificationListener<ScrollNotification>(
                    onNotification: _onNotification,
                    child: RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 8);
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
                          return ContainerWidget(container: status.data[index]);
                        },
                      ),
                    ),
                  )),
                ],
              );
            }
            return const SizedBox.shrink();
          }),
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
        sl<ContainersBloc>().add(ContainerLoadEvent(
            onDone: (event) async {
              await Future.delayed(const Duration(seconds: 1));
              loadMoreBloc.add(event);
            },
            filters: widget.filterController));
      },
      metaModel: sl<ContainersBloc>().state.metaModel,
    );
    return true;
  }
}
