import 'package:app/core/shared/imports.dart';
import 'package:app/feature/container_expenses/presentation/view/pages/sets_widget.dart';
import 'package:app/feature/loading_more/bloc/loading_more_bloc.dart';
import 'package:app/feature/loading_more/view/loading_more_widget.dart';
import 'package:app/feature/packages/data/models/packages_filter.dart';
import 'package:app/feature/packages/presentation/blocs/all/packages_bloc.dart';
import 'package:app/feature/packages/presentation/view/widgets/package_status_filter_bar.dart';
import 'package:app/feature/packages/presentation/view/widgets/package_widget.dart';
import 'package:app/widgets/status_widgets/export_status_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({super.key, required this.filterController});
  final PackagesFilterModel filterController;
  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  Future<void> _onRefresh(bool empty) async {
    packagesBloc.add(PackageLoadEvent(
        empty: empty, refresh: true, filters: packagesFilterModel));

    await packagesBloc.stream.first;
  }

  PackagesFilterModel packagesFilterModel =
      const PackagesFilterModel(setNumber: firstSet);
  PackageStatusFilter statusFilter = PackageStatusFilter.all;
  @override
  void initState() {
    packagesFilterModel = widget.filterController;
    loadMoreBloc = LoadMoreBloc();
    super.initState();
    logger("initState");
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (packagesBloc.state.loadIsNot) {
        packagesBloc.add(PackageLoadEvent(filters: packagesFilterModel));
      }
    });
  }

  @override
  void dispose() {
    logger("dispose");
    super.dispose();
  }

  double totalY = 0;

  int length = 0;
  late LoadMoreBloc loadMoreBloc;
  PackagesBloc packagesBloc = PackagesBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => packagesBloc,
      child: Scaffold(
        appBar: appConfig.app == App.rbb
            ? null
            : AppBar(title: Text(Trans.packages.trans())),
        body: Column(
          children: [
            BlocConsumer<PackagesBloc, PackagesState>(
              listener: (context, status) {},
              builder: (context, status) {
                if (status is PackagesLoadedState) {
                  final sta = status.metaModel;
                  length = sta.xTotalSets;
                  final filteredData = status.data
                      .where((package) => statusFilter.matches(
                          packageStatus: package.packageStatus,
                          containerStatus: package.container.containerStatus,
                          arrivalDate: package.container.arrivalDate))
                      .toList();
                  totalY = filteredData.fold(
                      0.0,
                      (previousValue, element) =>
                          previousValue + element.totalPrice);
                } else {
                  totalY = 0;
                }
                return SetsWidget(
                  selected: packagesFilterModel.setNumber,
                  maxLength: length,
                  totalY: totalY,
                  onChange: (index) {
                    packagesFilterModel =
                        packagesFilterModel.copyWith(setNumber: index);
                    _onRefresh(true);
                  },
                );
              },
            ),
            PackageStatusFilterBar(
              selected: statusFilter,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              onChanged: (value) {
                setState(() => statusFilter = value);
              },
            ),
            BlocConsumer<PackagesBloc, PackagesState>(
                listener: (context, status) {},
                builder: (context, status) {
                  if (status is PackagesLoadingState ||
                      status is PackageInitialState) {
                    return const Expanded(child: LoadingWidget());
                  } else if (status is PackagesErrorState) {
                    return Expanded(
                      child: FailureScreen(
                          name: Trans.packages.trans(),
                          failure: status.failure,
                          onRefresh: () => _onRefresh(false)),
                    );
                  } else if (status is PackagesEmptyState) {
                    return Expanded(
                      child: NoDataFound(
                          onRefresh: () => _onRefresh(false),
                          text: Trans.noDataFound.trans(
                              args: [Trans.packages.trans()],
                              context: context)),
                    );
                  } else if (status is PackagesLoadedState) {
                    final filteredData = status.data
                        .where((package) => statusFilter.matches(
                            packageStatus: package.packageStatus,
                            containerStatus: package.container.containerStatus,
                            arrivalDate: package.container.arrivalDate))
                        .toList();
                    if (filteredData.isEmpty) {
                      return Expanded(
                        child: NoDataFound(
                            onRefresh: () => _onRefresh(false),
                            text: Trans.noDataFound.trans(
                                args: [Trans.packages.trans()],
                                context: context)),
                      );
                    }
                    return Expanded(
                        child: NotificationListener<ScrollNotification>(
                      onNotification: _onNotification,
                      child: RefreshIndicator(
                        onRefresh: () => _onRefresh(false),
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            if (appConfig.isRbb) {
                              return const SizedBox(height: 8);
                            }
                            return const Divider(height: 8);
                          },
                          shrinkWrap: false,
                          padding: const EdgeInsets.all(8),
                          physics: const AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          controller: scrollController,
                          itemCount: filteredData.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == filteredData.length) {
                              return LoadMoreWidget(loadMoreBloc: loadMoreBloc);
                            }
                            return PackageWidget(package: filteredData[index]);
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
        packagesBloc.add(PackageLoadEvent(
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
