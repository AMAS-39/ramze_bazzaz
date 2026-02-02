import 'package:app/core/shared/imports.dart';
import 'package:app/feature/packages/presentation/blocs/all/packages_bloc.dart';
import 'package:app/feature/packages/presentation/blocs/view_one/package_bloc.dart';
import 'package:app/feature/packages/presentation/view/widgets/package_details_widget.dart';
import 'package:app/widgets/status_widgets/export_status_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PackageDetailsScreen extends StatefulWidget {
  const PackageDetailsScreen({super.key, required this.id, required this.name});
  final int id;
  final String name;

  @override
  State<PackageDetailsScreen> createState() => _PackageDetailsScreenState();
}

class _PackageDetailsScreenState extends State<PackageDetailsScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      onePackageBloc.add(OnePackageGetEvent(id: widget.id));
    });
    super.initState();
  }

  OnePackageBloc onePackageBloc = OnePackageBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => onePackageBloc,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.name)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: BlocConsumer<OnePackageBloc, OnePackageState>(
                    listener: (context, status) {
              if (status is OnePackageLoadedState && (status).failure != null) {
                showFailedFlashBar(status.failure!.error.reason);
              }
              logger("status $status");
            }, builder: (context, status) {
              if (status is OnePackageLoadingState ||
                  status is OnePackageInitialState) {
                return const LoadingWidget();
              } else if (status is OnePackageErrorState) {
                return FailureScreen(
                    name: Trans.packages.trans(),
                    failure: status.failure,
                    onRefresh: _onRefresh);
              } else if (status is PackagesEmptyState) {
                return NoDataFound(
                    onRefresh: _onRefresh,
                    text: Trans.noDataFound.trans(
                        args: [Trans.packages.trans()], context: context));
              } else if (status is OnePackageLoadedState) {
                return Column(children: [
                  Expanded(
                      child: RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: PackageDetailsWidget(package: status.data),
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
    onePackageBloc.add(OnePackageGetEvent(id: widget.id));
    await onePackageBloc.stream.first;
  }
}
