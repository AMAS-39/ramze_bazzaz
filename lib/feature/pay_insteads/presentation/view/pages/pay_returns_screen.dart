import 'package:app/core/shared/imports.dart';
import 'package:app/feature/container_expenses/presentation/view/pages/sets_widget.dart';
import 'package:app/feature/loading_more/bloc/loading_more_bloc.dart';
import 'package:app/feature/loading_more/view/loading_more_widget.dart';
import 'package:app/feature/pay_insteads/data/models/pay_insteads_filter.dart';
import 'package:app/feature/pay_insteads/presentation/blocs/all/pay_insteads_bloc.dart';
import 'package:app/feature/pay_insteads/presentation/view/widgets/pay_instead_widget.dart';
import 'package:app/widgets/status_widgets/export_status_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PayReturnsScreen extends StatefulWidget {
  const PayReturnsScreen({super.key, required this.filterController});
  final PayInsteadsFilterModel filterController;
  @override
  State<PayReturnsScreen> createState() => _PayReturnsScreenState();
}

class _PayReturnsScreenState extends State<PayReturnsScreen> {
  Future<void> _onRefresh(bool empty) async {
    packagesBloc.add(PayInsteadLoadEvent(
        empty: empty, refresh: true, filters: packagesFilterModel));

    await packagesBloc.stream.first;
  }

  PayInsteadsFilterModel packagesFilterModel =
      const PayInsteadsFilterModel(isLost: false, setNumber: firstSet);
  @override
  void initState() {
    packagesFilterModel = widget.filterController;
    loadMoreBloc = LoadMoreBloc();
    super.initState();
    logger("initState");
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (packagesBloc.state.loadIsNot) {
        packagesBloc.add(PayInsteadLoadEvent(filters: packagesFilterModel));
      }
    });
  }

  @override
  void dispose() {
    logger("dispose");
    super.dispose();
  }

  int length = 0;

  double totalY = 0;
  double totalS = 0;

  late LoadMoreBloc loadMoreBloc;
  PayInsteadsBloc packagesBloc = PayInsteadsBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => packagesBloc,
      child: Scaffold(
        appBar: appConfig.app == App.rbb
            ? null
            : AppBar(title: Text(Trans.payReturns.trans())),
        body: Column(
          children: [
            BlocConsumer<PayInsteadsBloc, PayInsteadsState>(
              listener: (context, status) {},
              builder: (context, status) {
                if (status is PayInsteadsLoadedState) {
                  final sta = status.metaModel;
                  length = sta.xTotalSets;

                  totalY = status.data.fold(
                      0.0,
                      (previousValue, element) =>
                          previousValue + element.totalPrice);
                  totalS = status.data.fold(
                      0.0,
                      (previousValue, element) =>
                          previousValue + element.forgivePrice);
                } else {
                  totalY = 0;
                  totalS = 0;
                }
                return SetsWidget(
                  totalY: totalY,
                  totalS: totalS,
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
            BlocConsumer<PayInsteadsBloc, PayInsteadsState>(
                listener: (context, status) {},
                builder: (context, status) {
                  if (status is PayInsteadsLoadingState ||
                      status is PayInsteadInitialState) {
                    return const Expanded(child: LoadingWidget());
                  } else if (status is PayInsteadsErrorState) {
                    return Expanded(
                      child: FailureScreen(
                          name: Trans.payReturns.trans(),
                          failure: status.failure,
                          onRefresh: () => _onRefresh(false)),
                    );
                  } else if (status is PayInsteadsEmptyState) {
                    return Expanded(
                      child: NoDataFound(
                          onRefresh: () => _onRefresh(false),
                          text: Trans.noDataFound.trans(
                              args: [Trans.payReturns.trans()],
                              context: context)),
                    );
                  } else if (status is PayInsteadsLoadedState) {
                    return Expanded(
                        child: NotificationListener<ScrollNotification>(
                      onNotification: _onNotification,
                      child: RefreshIndicator(
                        onRefresh: () => _onRefresh(false),
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            if (appConfig.isKostolog) {
                              return const Divider(height: 8);
                            }

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
                            return PayInsteadWidget(
                                payInstead: status.data[index]);
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
        packagesBloc.add(PayInsteadLoadEvent(
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
