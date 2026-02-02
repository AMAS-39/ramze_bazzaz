import 'package:app/core/shared/imports.dart';
import 'package:app/feature/container_expenses/presentation/view/pages/sets_widget.dart';
import 'package:app/feature/loading_more/bloc/loading_more_bloc.dart';
import 'package:app/feature/loading_more/view/loading_more_widget.dart';
import 'package:app/feature/payments/data/models/payments_filter.dart';
import 'package:app/feature/payments/presentation/blocs/all/payments_bloc.dart';
import 'package:app/feature/payments/presentation/view/widgets/payment_widget.dart';
import 'package:app/widgets/status_widgets/export_status_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key, required this.filterController});
  final PaymentsFilterModel filterController;
  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  Future<void> _onRefresh(bool empty) async {
    packagesBloc.add(PaymentLoadEvent(
        empty: empty, refresh: true, filters: packagesFilterModel));

    await packagesBloc.stream.first;
  }

  PaymentsFilterModel packagesFilterModel =
      const PaymentsFilterModel(setNumber: firstSet);
  @override
  void initState() {
    packagesFilterModel = widget.filterController;
    loadMoreBloc = LoadMoreBloc();
    super.initState();
    logger("initState");
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (packagesBloc.state.loadIsNot) {
        packagesBloc.add(PaymentLoadEvent(filters: packagesFilterModel));
      }
    });
  }

  @override
  void dispose() {
    logger("dispose");
    super.dispose();
  }

  int length = 0;

  double forgivePrice = 0;
  double price = 0;

  late LoadMoreBloc loadMoreBloc;
  PaymentsBloc packagesBloc = PaymentsBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => packagesBloc,
      child: Scaffold(
        // appBar: appConfig.app == App.rbb
        //     ? null
        //     : AppBar(title: Text(Trans.payments.trans())),
        body: Column(
          children: [
            BlocConsumer<PaymentsBloc, PaymentsState>(
              listener: (context, status) {},
              builder: (context, status) {
                if (status is PaymentsLoadedState) {
                  final sta = status.metaModel;
                  length = sta.xTotalSets;
                  forgivePrice = status.data.fold(
                      0.0,
                      (previousValue, element) =>
                          previousValue + element.forgivePrice);
                  price = status.data.fold(
                      0.0,
                      (previousValue, element) =>
                          previousValue + (element.price));
                } else {
                  forgivePrice = 0;
                  price = 0;
                }
                return SetsWidget(
                  selected: packagesFilterModel.setNumber,
                  maxLength: length,
                  totalS: price,
                  totalY: forgivePrice,
                  onChange: (index) {
                    packagesFilterModel =
                        packagesFilterModel.copyWith(setNumber: index);
                    _onRefresh(true);
                  },
                );
              },
            ),
            BlocConsumer<PaymentsBloc, PaymentsState>(
                listener: (context, status) {},
                builder: (context, status) {
                  if (status is PaymentsLoadingState ||
                      status is PaymentInitialState) {
                    return const Expanded(child: LoadingWidget());
                  } else if (status is PaymentsErrorState) {
                    return Expanded(
                      child: FailureScreen(
                          name: Trans.payments.trans(),
                          failure: status.failure,
                          onRefresh: () => _onRefresh(false)),
                    );
                  } else if (status is PaymentsEmptyState) {
                    return Expanded(
                      child: NoDataFound(
                          onRefresh: () => _onRefresh(false),
                          text: Trans.noDataFound.trans(
                              args: [Trans.payments.trans()],
                              context: context)),
                    );
                  } else if (status is PaymentsLoadedState) {
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
                            return PaymentWidget(payment: status.data[index]);
                          },
                        ),
                      ),
                    ));
                  }
                  return const SizedBox.shrink();
                }),
            BlocConsumer<PaymentsBloc, PaymentsState>(
              listener: (context, status) {},
              builder: (context, status) {
                if (status is PaymentsLoadedState) {
                  return PaymentInfo(data: status);
                }
                return const SizedBox();
              },
            ),
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
        packagesBloc.add(PaymentLoadEvent(
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

class PaymentInfo extends StatefulWidget {
  const PaymentInfo({super.key, required this.data});
  final PaymentsLoadedState data;
  @override
  State<PaymentInfo> createState() => _PaymentInfoState();
}

class _PaymentInfoState extends State<PaymentInfo> {
  @override
  Widget build(BuildContext context) {
    final total = widget.data.data
        .fold(0.0, (previousValue, element) => previousValue + element.price);
    double totalPaid = checkDouble(widget.data.metaModel.header['price'] ??
            widget.data.metaModel.header['Price']) +
        checkDouble(widget.data.metaModel.header['forgiveprice'] ??
            widget.data.metaModel.header['ForgivPrice'] ??
            widget.data.metaModel.header['Forgiveprice']);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${Trans.total.trans()}: ${total.format}",
            style: context.style16W500B,
          ),
          Text(
            "${Trans.totalPaid.trans()}: ${totalPaid.format}",
            style: context.style16W500B,
          ),
        ],
      ),
    );
  }
}
