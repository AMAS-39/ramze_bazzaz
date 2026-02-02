import 'package:app/core/shared/imports.dart';
import 'package:app/feature/container_expenses/data/models/container_expenses_filter.dart';
import 'package:app/feature/container_expenses/presentation/blocs/all/container_expenses_bloc.dart';
import 'package:app/feature/container_expenses/presentation/view/widgets/container_expense_widget.dart';
import 'package:app/feature/loading_more/bloc/loading_more_bloc.dart';
import 'package:app/feature/loading_more/view/loading_more_widget.dart';
import 'package:app/widgets/status_widgets/export_status_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sets_widget.dart';

class ContainerExpensesScreen extends StatefulWidget {
  const ContainerExpensesScreen({super.key, required this.filterController});
  final ContainerExpensesFilterModel filterController;
  @override
  State<ContainerExpensesScreen> createState() =>
      _ContainerExpensesScreenState();
}

class _ContainerExpensesScreenState extends State<ContainerExpensesScreen> {
  Future<void> _onRefresh(bool empty) async {
    packagesBloc.add(ContainerExpenseLoadEvent(
        empty: empty, refresh: true, filters: packagesFilterModel));

    await packagesBloc.stream.first;
  }

  ContainerExpensesFilterModel packagesFilterModel =
      const ContainerExpensesFilterModel(setNumber: firstSet);
  @override
  void initState() {
    packagesFilterModel = widget.filterController;
    loadMoreBloc = LoadMoreBloc();
    super.initState();
    logger("initState");
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (packagesBloc.state.loadIsNot) {
        packagesBloc
            .add(ContainerExpenseLoadEvent(filters: packagesFilterModel));
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
  ContainerExpensesBloc packagesBloc = ContainerExpensesBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => packagesBloc,
      child: Scaffold(
        // appBar: appConfig.app == App.rbb
        //     ? null
        //     : AppBar(title: Text(Trans.containerExpenses.trans())),
        body: Column(
          children: [
            BlocConsumer<ContainerExpensesBloc, ContainerExpensesState>(
              listener: (context, status) {},
              builder: (context, status) {
                if (status is ContainerExpensesLoadedState) {
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
            BlocConsumer<ContainerExpensesBloc, ContainerExpensesState>(
                listener: (context, status) {},
                builder: (context, status) {
                  if (status is ContainerExpensesLoadingState ||
                      status is ContainerExpenseInitialState) {
                    return const Expanded(child: LoadingWidget());
                  } else if (status is ContainerExpensesErrorState) {
                    return Expanded(
                      child: FailureScreen(
                          name: Trans.containerExpenses.trans(),
                          failure: status.failure,
                          onRefresh: () => _onRefresh(false)),
                    );
                  } else if (status is ContainerExpensesEmptyState) {
                    return Expanded(
                      child: NoDataFound(
                          onRefresh: () => _onRefresh(false),
                          text: Trans.noDataFound.trans(
                              args: [Trans.containerExpenses.trans()],
                              context: context)),
                    );
                  } else if (status is ContainerExpensesLoadedState) {
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
                            return ContainerExpenseWidget(
                                containerExpense: status.data[index]);
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
        packagesBloc.add(ContainerExpenseLoadEvent(
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
