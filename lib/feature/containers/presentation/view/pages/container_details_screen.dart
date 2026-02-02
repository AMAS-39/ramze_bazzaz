import 'package:app/core/shared/imports.dart';
import 'package:app/feature/containers/presentation/blocs/all/containers_bloc.dart';
import 'package:app/feature/containers/presentation/blocs/view_one/container_bloc.dart';
import 'package:app/feature/containers/presentation/view/widgets/container_details_widget.dart';
import 'package:app/widgets/status_widgets/export_status_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContainerDetailsScreen extends StatefulWidget {
  const ContainerDetailsScreen(
      {super.key, required this.id, required this.name});
  final int id;
  final String name;

  @override
  State<ContainerDetailsScreen> createState() => _ContainerDetailsScreenState();
}

class _ContainerDetailsScreenState extends State<ContainerDetailsScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      oneContainerBloc.add(OneContainerGetEvent(id: widget.id.toString()));
    });
    super.initState();
  }

  OneContainerBloc oneContainerBloc = OneContainerBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => oneContainerBloc,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.name)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: BlocConsumer<OneContainerBloc, OneContainerState>(
                    listener: (context, status) {
              if (status is OneContainerLoadedState &&
                  (status).failure != null) {
                showFailedFlashBar(status.failure!.error.reason);
              }
              logger("status $status");
            }, builder: (context, status) {
              if (status is OneContainerLoadingState ||
                  status is OneContainerInitialState) {
                return const LoadingWidget();
              } else if (status is OneContainerErrorState) {
                return FailureScreen(
                    name: Trans.containers.trans(),
                    failure: status.failure,
                    onRefresh: _onRefresh);
              } else if (status is ContainersEmptyState) {
                return NoDataFound(
                    onRefresh: _onRefresh,
                    text: Trans.noDataFound.trans(
                        args: [Trans.containers.trans()], context: context));
              } else if (status is OneContainerLoadedState) {
                return Column(children: [
                  Expanded(
                      child: RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ContainerDetailsWidget(container: status.data),
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
    oneContainerBloc.add(OneContainerGetEvent(id: widget.id.toString()));
    await oneContainerBloc.stream.first;
  }
}
