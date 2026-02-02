import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/shared/imports.dart';
import 'package:app/feature/slides/presentation/blocs/all/slides_bloc.dart';
import 'package:app/feature/slides/presentation/blocs/view_one/slide_bloc.dart';
import 'package:app/feature/slides/presentation/view/widgets/slide_details_widget.dart';
import 'package:app/widgets/status_widgets/export_status_widgets.dart';

class SlideDetailsScreen extends StatefulWidget {
  const SlideDetailsScreen({super.key, required this.id, required this.name});
  final  int id;
  final String name;

  @override
  State<SlideDetailsScreen> createState() => _SlideDetailsScreenState();
}

class _SlideDetailsScreenState extends State<SlideDetailsScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      oneSlideBloc.add(OneSlideGetEvent(id: widget.id));
    });
    super.initState();
  }

  OneSlideBloc oneSlideBloc = OneSlideBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => oneSlideBloc,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.name)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: BlocConsumer<OneSlideBloc, OneSlideState>(
                    listener: (context, status) {
              if (status is OneSlideLoadedState && (status).failure != null) {
                showFailedFlashBar(status.failure!.error.reason);
              }
              logger("status $status");
            }, builder: (context, status) {
              if (status is OneSlideLoadingState ||
                  status is OneSlideInitialState) {
                return const LoadingWidget();
              } else if (status is OneSlideErrorState) {
                return FailureScreen( name:Trans.slides.trans(),
                    failure: status.failure, onRefresh: _onRefresh);
              } else if (status is SlidesEmptyState) {
                return NoDataFound(
                    onRefresh: _onRefresh,
                    text: Trans.noDataFound.trans(
                        args: [Trans.slides.trans()], context: context));
              } else if (status is OneSlideLoadedState) {
                return Column(children: [
                  Expanded(
                      child: RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: SlideDetailsWidget(slide: status.data),
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
    oneSlideBloc.add(OneSlideGetEvent(id: widget.id));
        await oneSlideBloc.stream.first;

  }
}
