import 'package:app/core/shared/imports.dart';
import 'package:app/feature/containers/data/models/containers_model.dart';
import 'package:app/feature/loading_more/bloc/loading_more_bloc.dart';
import 'package:app/feature/loading_more/view/loading_more_widget.dart';
import 'package:app/feature/packages/data/models/packages_filter.dart';
import 'package:app/feature/packages/data/models/packages_model.dart';
import 'package:app/feature/packages/presentation/blocs/all/packages_bloc.dart';
import 'package:app/feature/packages/presentation/view/widgets/package_widget.dart';
import 'package:app/widgets/status_widgets/export_status_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PackagesTracking extends StatefulWidget {
  const PackagesTracking(
      {super.key,
      required this.filterController,
      required this.scrollController,
      required this.statusFilter});
  final PackagesFilterModel filterController;
  final ScrollController scrollController;
  final PackageStatusFilter statusFilter;


  @override
  State<PackagesTracking> createState() => PackagesTrackingState();
}

class PackagesTrackingState extends State<PackagesTracking> {
  Future<void> _onRefresh() async {
    sl<PackagesBloc>()
        .add(PackageLoadEvent(refresh: true, filters: widget.filterController));

    await sl<PackagesBloc>().stream.first;
  }

  @override
  void initState() {
    loadMoreBloc = LoadMoreBloc();
    super.initState();
    logger("initState");
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (sl<PackagesBloc>().state.loadIsNot) {
        sl<PackagesBloc>()
            .add(PackageLoadEvent(filters: widget.filterController));
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
    return BlocConsumer<PackagesBloc, PackagesState>(
        listener: (context, status) {},
        builder: (context, status) {
          if (status is PackagesLoadingState || status is PackageInitialState) {
            return SliverFillRemaining(
              child: LoadingWidget(
                padding: EdgeInsets.only(left: 20, right: 20),
                height: context.height,
                shrinWrap: true,
                skeletonChild: PackageWidget(
                    package: PackageModel(
                        id: 0,
                        description: "description",
                        date: DateTime.now(),
                        packageStatus: PackageStatus.InShipping,
                        height: 0,
                        width: 0,
                        length: 0,
                        weight: 0,
                        qty: 0,
                        cbm: 0,
                        totalPrice: 0,
                        setNumber: 0,
                        sort: 0,
                        itemId: 0,
                        container: ContainerModel(
                            date: DateTime.now(),
                            containerStatus: ContainerStatus.InShipping,
                            containerTypeName: "Name",
                            containerTypeId: 0,
                            number: "0",
                            originCountryId: 0,
                            destinationCountryId: 0,
                            id: 0),
                        containerId: 0,
                        customerName: "Name Here",
                        customerId: 0)),
              ),
            );
          } else if (status is PackagesErrorState) {
            return SliverFillRemaining(
                child: FailureScreen(
                    name: Trans.packages.trans(),
                    failure: status.failure,
                    onRefresh: _onRefresh));
          } else if (status is PackagesEmptyState) {
            return SliverFillRemaining(
              child: NoDataFound(
                  onRefresh: _onRefresh,
                  text: Trans.noDataFound
                      .trans(args: [Trans.packages.trans()], context: context)),
            );
          } else if (status is PackagesLoadedState) {
            final filteredData = status.data
                .where((package) => widget.statusFilter.matches(
                    packageStatus: package.packageStatus,
                    containerStatus: package.container.containerStatus,
                    arrivalDate: package.container.arrivalDate))
                .toList();
            if (filteredData.isEmpty) {
              return SliverFillRemaining(
                child: NoDataFound(
                    onRefresh: _onRefresh,
                    text: Trans.noDataFound
                        .trans(args: [Trans.packages.trans()], context: context)),
              );
            }
            return NotificationListener<ScrollNotification>(
              onNotification: onNotification,
              child: SliverList.separated(
                separatorBuilder: (context, index) {
                  if (appConfig.app == App.rbb) {
                    return const SizedBox(height: 8);
                  } else {
                    return const Divider(height: 3);
                  }
                },
                itemCount: filteredData.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == filteredData.length) {
                    return LoadMoreWidget(loadMoreBloc: loadMoreBloc);
                  }
                  return Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: PackageWidget(
                        tracking: true, package: filteredData[index]),
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        });
  }

  bool onNotification(ScrollNotification scrollNotification) {
    onScroll(
      notification: scrollNotification,
      loadMoreBloc: loadMoreBloc,
      scrollController: widget.scrollController,
      onLoad: () {
        loadMoreBloc.add(const LoadingMoreEvent(
            status: LoadingMoreStatus(
                failure: null, pagination: Pagination.loading)));
        sl<PackagesBloc>().add(PackageLoadEvent(
            onDone: (event) async {
              await Future.delayed(const Duration(seconds: 1));
              loadMoreBloc.add(event);
            },
            filters: widget.filterController));
      },
      metaModel: sl<PackagesBloc>().state.metaModel,
    );
    return true;
  }
}
