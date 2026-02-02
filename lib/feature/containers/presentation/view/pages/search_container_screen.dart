import 'package:app/core/shared/imports.dart';
import 'package:app/feature/containers/presentation/blocs/all/containers_bloc.dart';
import 'package:app/feature/containers/presentation/blocs/view_one/container_bloc.dart';
import 'package:app/feature/containers/presentation/view/widgets/container_details_widget.dart';
import 'package:app/widgets/form_widgets/form_widgets.dart';
import 'package:app/widgets/status_widgets/export_status_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchForContainerScreen extends StatefulWidget {
  const SearchForContainerScreen({super.key, this.viewAppBar = false});
  final bool viewAppBar;
  @override
  State<SearchForContainerScreen> createState() =>
      _SearchForContainerScreenState();
}

class _SearchForContainerScreenState extends State<SearchForContainerScreen> {
  void onSearch(String id) {
    this.id = id;
    if (!checkIsNull(id)) {
      oneContainerBloc.add(OneContainerGetEvent(id: id));
    } else {
      oneContainerBloc.add(OneContainerReinitEvent());
    }
  }

  String id = "";
  final TextEditingController controller = TextEditingController();

  OneContainerBloc oneContainerBloc = OneContainerBloc();
  Debouncer debouncer = Debouncer();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => oneContainerBloc,
      child: Scaffold(
        appBar: widget.viewAppBar
            ? AppBar(title: Text(Trans.containers.trans()))
            : null,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20).copyWith(bottom: 0),
              child: GeneralTextFiled(
                  onChange: (p0) {
                    debouncer.run(() {
                      onSearch(p0);
                    });
                  },
                  hintText: Trans.searchHere.trans(),
                  controller: controller),
            ),
            Expanded(
                child: BlocConsumer<OneContainerBloc, OneContainerState>(
                    listener: (context, status) {
              if (status is OneContainerLoadedState &&
                  (status).failure != null) {
                showFailedFlashBar(status.failure!.error.reason);
              }
              logger("status $status");
            }, builder: (context, status) {
              logger("status $status");

              if (status is OneContainerInitialState) {
                return const SizedBox();
              } else if (status is OneContainerLoadingState) {
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
    onSearch(id);
    await oneContainerBloc.stream.first;
  }
}
