import 'package:app/core/shared/imports.dart';
import 'package:app/feature/loading_more/bloc/loading_more_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadMoreWidget extends StatefulWidget {
  const LoadMoreWidget({super.key, required this.loadMoreBloc});
  final LoadMoreBloc loadMoreBloc;
  @override
  State<LoadMoreWidget> createState() => _LoadMoreWidgetState();
}

class _LoadMoreWidgetState extends State<LoadMoreWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: BlocProvider.value(
                value: widget.loadMoreBloc,
                child: Builder(builder: (context) {
                  return BlocListener<LoadMoreBloc, LoadingMoreStatus>(
                      listener: (context, state) {
                    if (state.pagination.isError && state.failure != null) {
                      showFailedFlashBar(state.failure!.error.message);
                    } else if (state.pagination.isMatch) {
                      showSuccessFlashBar(Trans.matchToEnd.trans());
                    }
                  }, child: BlocBuilder<LoadMoreBloc, LoadingMoreStatus>(
                    builder: (context, state) {
                      if (widget.loadMoreBloc.state.pagination.isNotMatch) {
                        return const SizedBox.shrink();
                      } else if (widget.loadMoreBloc.state.pagination.isMatch) {
                        return const SizedBox.shrink();
                      } else if (state.pagination.isError &&
                          state.failure != null) {
                        return Text(state.failure?.error.reason ?? "_");
                      } else if (widget
                          .loadMoreBloc.state.pagination.isLoading) {
                        return SizedBox(
                            height: 20.sp,
                            width: 20.sp,
                            child: const CircularProgressIndicator(
                                strokeWidth: 3));
                      }

                      return const SizedBox.shrink();
                    },
                  ));
                }))));
  }
}
