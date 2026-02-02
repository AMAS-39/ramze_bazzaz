import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/shared/imports.dart';
import 'package:app/feature/attachments/presentation/blocs/all/attachments_bloc.dart';
import 'package:app/feature/attachments/presentation/blocs/view_one/attachment_bloc.dart';
import 'package:app/feature/attachments/presentation/view/widgets/attachment_details_widget.dart';
import 'package:app/widgets/status_widgets/export_status_widgets.dart';

class AttachmentDetailsScreen extends StatefulWidget {
  const AttachmentDetailsScreen({super.key, required this.id, required this.name});
  final  int id;
  final String name;

  @override
  State<AttachmentDetailsScreen> createState() => _AttachmentDetailsScreenState();
}

class _AttachmentDetailsScreenState extends State<AttachmentDetailsScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      oneAttachmentBloc.add(OneAttachmentGetEvent(id: widget.id));
    });
    super.initState();
  }

  OneAttachmentBloc oneAttachmentBloc = OneAttachmentBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => oneAttachmentBloc,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.name)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: BlocConsumer<OneAttachmentBloc, OneAttachmentState>(
                    listener: (context, status) {
              if (status is OneAttachmentLoadedState && (status).failure != null) {
                showFailedFlashBar(status.failure!.error.reason);
              }
              logger("status $status");
            }, builder: (context, status) {
              if (status is OneAttachmentLoadingState ||
                  status is OneAttachmentInitialState) {
                return const LoadingWidget();
              } else if (status is OneAttachmentErrorState) {
                return FailureScreen( name:Trans.attachments.trans(),
                    failure: status.failure, onRefresh: _onRefresh);
              } else if (status is AttachmentsEmptyState) {
                return NoDataFound(
                    onRefresh: _onRefresh,
                    text: Trans.noDataFound.trans(
                        args: [Trans.attachments.trans()], context: context));
              } else if (status is OneAttachmentLoadedState) {
                return Column(children: [
                  Expanded(
                      child: RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: AttachmentDetailsWidget(attachment: status.data),
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
    oneAttachmentBloc.add(OneAttachmentGetEvent(id: widget.id));
        await oneAttachmentBloc.stream.first;

  }
}
