import 'package:app/core/shared/imports.dart';
import 'package:app/feature/container_expenses/presentation/blocs/all/container_expenses_bloc.dart';
import 'package:app/feature/container_expenses/presentation/blocs/view_one/container_expense_bloc.dart';
import 'package:app/feature/container_expenses/presentation/view/widgets/container_expense_details_widget.dart';
import 'package:app/widgets/status_widgets/export_status_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContainerExpenseDetailsScreen extends StatefulWidget {
  const ContainerExpenseDetailsScreen(
      {super.key, required this.id, required this.name});
  final int id;
  final String name;

  @override
  State<ContainerExpenseDetailsScreen> createState() =>
      _ContainerExpenseDetailsScreenState();
}

class _ContainerExpenseDetailsScreenState
    extends State<ContainerExpenseDetailsScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      oneContainerExpenseBloc.add(OneContainerExpenseGetEvent(id: widget.id));
    });
    super.initState();
  }

  OneContainerExpenseBloc oneContainerExpenseBloc = OneContainerExpenseBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => oneContainerExpenseBloc,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.name)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: BlocConsumer<OneContainerExpenseBloc,
                    OneContainerExpenseState>(listener: (context, status) {
              if (status is OneContainerExpenseLoadedState &&
                  (status).failure != null) {
                showFailedFlashBar(status.failure!.error.reason);
              }
              logger("status $status");
            }, builder: (context, status) {
              if (status is OneContainerExpenseLoadingState ||
                  status is OneContainerExpenseInitialState) {
                return const LoadingWidget();
              } else if (status is OneContainerExpenseErrorState) {
                return FailureScreen(
                    name: Trans.containerExpenses.trans(),
                    failure: status.failure,
                    onRefresh: _onRefresh);
              } else if (status is ContainerExpensesEmptyState) {
                return NoDataFound(
                    onRefresh: _onRefresh,
                    text: Trans.noDataFound.trans(
                        args: [Trans.containerExpenses.trans()],
                        context: context));
              } else if (status is OneContainerExpenseLoadedState) {
                return Column(children: [
                  Expanded(
                      child: RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ContainerExpenseDetailsWidget(
                        containerExpense: status.data),
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
    oneContainerExpenseBloc.add(OneContainerExpenseGetEvent(id: widget.id));
    await oneContainerExpenseBloc.stream.first;
  }
}
