import 'package:app/core/shared/imports.dart';
import 'package:app/feature/pay_insteads/presentation/blocs/all/pay_insteads_bloc.dart';
import 'package:app/feature/pay_insteads/presentation/blocs/view_one/pay_instead_bloc.dart';
import 'package:app/feature/pay_insteads/presentation/view/widgets/pay_instead_details_widget.dart';
import 'package:app/widgets/status_widgets/export_status_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PayInsteadDetailsScreen extends StatefulWidget {
  const PayInsteadDetailsScreen(
      {super.key, required this.id, required this.name});
  final int id;
  final String name;

  @override
  State<PayInsteadDetailsScreen> createState() =>
      _PayInsteadDetailsScreenState();
}

class _PayInsteadDetailsScreenState extends State<PayInsteadDetailsScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      onePayInsteadBloc.add(OnePayInsteadGetEvent(id: widget.id));
    });
    super.initState();
  }

  OnePayInsteadBloc onePayInsteadBloc = OnePayInsteadBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => onePayInsteadBloc,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.name)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: BlocConsumer<OnePayInsteadBloc, OnePayInsteadState>(
                    listener: (context, status) {
              if (status is OnePayInsteadLoadedState &&
                  (status).failure != null) {
                showFailedFlashBar(status.failure!.error.reason);
              }
              logger("status $status");
            }, builder: (context, status) {
              if (status is OnePayInsteadLoadingState ||
                  status is OnePayInsteadInitialState) {
                return const LoadingWidget();
              } else if (status is OnePayInsteadErrorState) {
                return FailureScreen(
                    name: Trans.payInsteads.trans(),
                    failure: status.failure,
                    onRefresh: _onRefresh);
              } else if (status is PayInsteadsEmptyState) {
                return NoDataFound(
                    onRefresh: _onRefresh,
                    text: Trans.noDataFound.trans(
                        args: [Trans.payInsteads.trans()], context: context));
              } else if (status is OnePayInsteadLoadedState) {
                return Column(children: [
                  Expanded(
                      child: RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: PayInsteadDetailsWidget(payInstead: status.data),
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
    onePayInsteadBloc.add(OnePayInsteadGetEvent(id: widget.id));
    await onePayInsteadBloc.stream.first;
  }
}
