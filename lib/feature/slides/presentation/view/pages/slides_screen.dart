import 'package:app/core/shared/imports.dart';
import 'package:app/feature/loading_more/bloc/loading_more_bloc.dart';
import 'package:app/feature/slides/data/models/slides_filter.dart';
import 'package:app/feature/slides/data/models/slides_model.dart';
import 'package:app/feature/slides/presentation/blocs/all/slides_bloc.dart';
import 'package:app/feature/slides/presentation/view/widgets/slide_widget.dart';
import 'package:app/widgets/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SlidesScreen extends StatefulWidget {
  const SlidesScreen({super.key, required this.filterController});
  final SlidesFilterModel filterController;
  @override
  State<SlidesScreen> createState() => _SlidesScreenState();
}

class _SlidesScreenState extends State<SlidesScreen> {
  Future<void> _onRefresh() async {
    sl<SlidesBloc>()
        .add(SlideLoadEvent(refresh: true, filters: widget.filterController));

    await sl<SlidesBloc>().stream.first;
  }

  @override
  void initState() {
    loadMoreBloc = LoadMoreBloc();
    super.initState();
    logger("initState");
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (sl<SlidesBloc>().state.loadIsNot) {
        sl<SlidesBloc>().add(SlideLoadEvent(filters: widget.filterController));
      }
    });
  }

  @override
  void dispose() {
    logger("dispose");
    super.dispose();
  }

  ValueNotifier<double> aspectRatio = ValueNotifier<double>(15);

  late LoadMoreBloc loadMoreBloc;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SlidesBloc, SlidesState>(
        listener: (context, status) {},
        builder: (context, status) {
          if (status is SlidesLoadingState || status is SlideInitialState) {
            return Skeletonizer(
              child: AspectRatio(
                  aspectRatio: 4 / 2.5,
                  child: MySlider(
                    indicatorType: IndicatorType.bottomEnd,
                    key: UniqueKey(),
                    itemCount: 1,
                    viewportFraction: 1,
                    itemBuilder: (p0, int index) {
                      return SizedBox(
                        width: context.width,
                        child: SlideWidget(
                            aspectRatio: aspectRatio,
                            slide:
                                SlideModel(id: 0, sort: 0, isAvailable: false)),
                      );
                    },
                    width: context.width,
                    indoctorWidth: 10,
                    indicator: true,
                    autoPlay: true,
                    canMoveing: true,
                    height: null,
                  )),
            );
          } else if (status is SlidesLoadedState) {
            return Builder(builder: (context) {
              return ValueListenableBuilder(
                  valueListenable: aspectRatio,
                  builder: (context, snapshot, v) {
                    return AspectRatio(
                        aspectRatio: 4 / 2.5,
                        child: MySlider(
                          indicatorType: IndicatorType.bottom,
                          key: UniqueKey(),
                          itemCount: status.data.length,
                          viewportFraction: 1,
                          itemBuilder: (p0, int index) {
                            return SizedBox(
                              width: context.width,
                              child: SlideWidget(
                                  aspectRatio: aspectRatio,
                                  slide: status.data[index]),
                            );
                          },
                          width: context.width,
                          indoctorWidth: 8,
                          
                          indicator: true,
                          autoPlay: true,
                          canMoveing: true,
                          height: null,
                        ));
                  });
            });
          }
          return const SizedBox.shrink();
        });
  }

  // ScrollController scrollController = ScrollController();
  // bool _onNotification(ScrollNotification scrollNotification) {
  //   onScroll(
  //     notification: scrollNotification,
  //     loadMoreBloc: loadMoreBloc,
  //     scrollController: scrollController,
  //     onLoad: () {
  //       loadMoreBloc.add(const LoadingMoreEvent(
  //           status: LoadingMoreStatus(
  //               failure: null, pagination: Pagination.loading)));
  //       sl<SlidesBloc>().add(SlideLoadEvent(
  //           onDone: (event) async {
  //             await Future.delayed(const Duration(seconds: 1));
  //             loadMoreBloc.add(event);
  //           },
  //           filters: widget.filterController));
  //     },
  //     metaModel: sl<SlidesBloc>().state.metaModel,
  //   );
  //   return true;
  // }
}
