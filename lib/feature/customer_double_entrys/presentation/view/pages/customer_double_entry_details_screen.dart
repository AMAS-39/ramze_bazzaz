import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/shared/imports.dart';
import 'package:app/feature/customer_double_entrys/presentation/blocs/all/customer_double_entrys_bloc.dart';
import 'package:app/feature/customer_double_entrys/presentation/blocs/view_one/customer_double_entry_bloc.dart';
import 'package:app/feature/customer_double_entrys/presentation/view/widgets/customer_double_entry_details_widget.dart';
import 'package:app/widgets/status_widgets/export_status_widgets.dart';

class CustomerDoubleEntryDetailsScreen extends StatefulWidget {
  const CustomerDoubleEntryDetailsScreen(
      {super.key, required this.id, required this.name});
  final int id;
  final String name;

  @override
  State<CustomerDoubleEntryDetailsScreen> createState() =>
      _CustomerDoubleEntryDetailsScreenState();
}

class _CustomerDoubleEntryDetailsScreenState
    extends State<CustomerDoubleEntryDetailsScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      oneCustomerDoubleEntryBloc
          .add(OneCustomerDoubleEntryGetEvent(id: widget.id));
    });
    super.initState();
  }

  OneCustomerDoubleEntryBloc oneCustomerDoubleEntryBloc =
      OneCustomerDoubleEntryBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => oneCustomerDoubleEntryBloc,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.name)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: BlocConsumer<OneCustomerDoubleEntryBloc,
                    OneCustomerDoubleEntryState>(listener: (context, status) {
              if (status is OneCustomerDoubleEntryLoadedState &&
                  (status).failure != null) {
                showFailedFlashBar(status.failure!.error.reason);
              }
              logger("status $status");
            }, builder: (context, status) {
              if (status is OneCustomerDoubleEntryLoadingState ||
                  status is OneCustomerDoubleEntryInitialState) {
                return const LoadingWidget();
              } else if (status is OneCustomerDoubleEntryErrorState) {
                return FailureScreen(
                    name: Trans.customerDoubleEntries.trans(),
                    failure: status.failure,
                    onRefresh: _onRefresh);
              } else if (status is CustomerDoubleEntrysEmptyState) {
                return NoDataFound(
                    onRefresh: _onRefresh,
                    text: Trans.noDataFound.trans(
                        args: [Trans.customerDoubleEntries.trans()],
                        context: context));
              } else if (status is OneCustomerDoubleEntryLoadedState) {
                return Column(children: [
                  Expanded(
                      child: RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: CustomerDoubleEntryDetailsWidget(
                        customerDoubleEntry: status.data),
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
    oneCustomerDoubleEntryBloc
        .add(OneCustomerDoubleEntryGetEvent(id: widget.id));
    await oneCustomerDoubleEntryBloc.stream.first;
  }
}
