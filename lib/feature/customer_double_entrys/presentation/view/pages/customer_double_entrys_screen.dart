import 'package:app/core/shared/imports.dart';
import 'package:app/feature/container_expenses/presentation/view/pages/sets_widget.dart';
import 'package:app/feature/customer_double_entrys/data/models/customer_double_entrys_filter.dart';
import 'package:app/feature/customer_double_entrys/data/repositories/export_helper.dart';
import 'package:app/feature/customer_double_entrys/presentation/blocs/all/customer_double_entrys_bloc.dart';
import 'package:app/feature/customer_double_entrys/presentation/view/widgets/customer_double_entry_widget.dart';
import 'package:app/feature/loading_more/bloc/loading_more_bloc.dart';
import 'package:app/feature/loading_more/view/loading_more_widget.dart';
import 'package:app/widgets/status_widgets/export_status_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CustomerDoubleEntrysScreen extends StatefulWidget {
  const CustomerDoubleEntrysScreen({super.key, required this.filterController});
  final CustomerDoubleEntrysFilterModel filterController;
  @override
  State<CustomerDoubleEntrysScreen> createState() =>
      _CustomerDoubleEntrysScreenState();
}

class _CustomerDoubleEntrysScreenState
    extends State<CustomerDoubleEntrysScreen> {
  Future<void> _onRefresh(bool empty) async {
    sl<CustomerDoubleEntrysBloc>().add(CustomerDoubleEntryLoadEvent(
        empty: empty, refresh: true, filters: packagesFilterModel));

    await sl<CustomerDoubleEntrysBloc>().stream.first;
  }

  CustomerDoubleEntrysFilterModel packagesFilterModel =
      const CustomerDoubleEntrysFilterModel(setNumber: firstSet);
  @override
  void initState() {
    loadMoreBloc = LoadMoreBloc();
    packagesFilterModel = packagesFilterModel;
    super.initState();
    logger("initState");
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (sl<CustomerDoubleEntrysBloc>().state.loadIsNot) {
        sl<CustomerDoubleEntrysBloc>()
            .add(CustomerDoubleEntryLoadEvent(filters: packagesFilterModel));
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.upload, color: Colors.white),
          onPressed: () async {
            final data = await exportToPDF(
                sl<CustomerDoubleEntrysBloc>().state.items, true);
            final save = await context.to(HtmlView(content: data));
            if (save == true) {
              showLoadingProgressAlert();
              await saveHtmlAsPdf(data, "Report", false);
              context.pop();
            }
          }),
      appBar: appConfig.app == App.rbb
          ? null
          : AppBar(title: Text(Trans.customerDoubleEntries.trans())),
      body: Column(
        children: [
          BlocConsumer<CustomerDoubleEntrysBloc, CustomerDoubleEntrysState>(
            listener: (context, status) {},
            builder: (context, status) {
              if (status is CustomerDoubleEntrysLoadedState) {
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
          Expanded(
            child: BlocConsumer<CustomerDoubleEntrysBloc,
                    CustomerDoubleEntrysState>(
                listener: (context, status) {},
                builder: (context, status) {
                  if (status is CustomerDoubleEntrysLoadingState ||
                      status is CustomerDoubleEntryInitialState) {
                    return const LoadingWidget();
                  } else if (status is CustomerDoubleEntrysErrorState) {
                    return FailureScreen(
                        name: Trans.customerDoubleEntries.trans(),
                        failure: status.failure,
                        onRefresh: () => _onRefresh(false));
                  } else if (status is CustomerDoubleEntrysEmptyState) {
                    return NoDataFound(
                        onRefresh: () => _onRefresh(false),
                        text: Trans.noDataFound.trans(
                            args: [Trans.customerDoubleEntries.trans()],
                            context: context));
                  } else if (status is CustomerDoubleEntrysLoadedState) {
                    return NotificationListener<ScrollNotification>(
                      onNotification: _onNotification,
                      child: RefreshIndicator(
                        onRefresh: () => _onRefresh(false),
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
                            return CustomerDoubleEntryWidget(
                                customerDoubleEntry: status.data[index]);
                          },
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),
          ),
        ],
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
        sl<CustomerDoubleEntrysBloc>().add(CustomerDoubleEntryLoadEvent(
            onDone: (event) async {
              await Future.delayed(const Duration(seconds: 1));
              loadMoreBloc.add(event);
            },
            filters: packagesFilterModel));
      },
      metaModel: sl<CustomerDoubleEntrysBloc>().state.metaModel,
    );
    return true;
  }
}

class HtmlView extends StatefulWidget {
  const HtmlView({super.key, required this.content});
  final String content;
  @override
  State<HtmlView> createState() => _HtmlViewState();
}

class _HtmlViewState extends State<HtmlView> {
  InAppWebViewController? controller;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Future.delayed(Duration(seconds: 1)).then(
          (value) {
            setState(() {});
          },
        );
      },
    );
    super.initState();
  }

  InAppWebViewSettings tt = InAppWebViewSettings(
      underPageBackgroundColor: Colors.white, useHybridComposition: false);
  final GlobalKey webViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  context.pop(true);
                },
                icon: Icon(Icons.download))
          ],
        ),
        body: InAppWebView(
          key: webViewKey,
          initialSettings: tt,
          onWebViewCreated: (cccontroller) async {
            controller = cccontroller;
            controller?.getContentHeight();
          },
          initialData: InAppWebViewInitialData(data: widget.content),
        ));
  }
}
