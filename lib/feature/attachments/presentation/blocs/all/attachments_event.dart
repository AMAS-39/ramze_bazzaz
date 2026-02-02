part of 'attachments_bloc.dart';

class AttachmentEvent extends Equatable {
  const AttachmentEvent();

  @override
  List<Object?> get props => [];
}

class AttachmentEmptyEvent extends AttachmentEvent {
  const AttachmentEmptyEvent();
}



class AttachmentDeleteEvent extends AttachmentEvent {
  final AttachmentModel model;
  const AttachmentDeleteEvent(this.model);
}

class AttachmentCreateEvent extends AttachmentEvent {
  final CreateAttachmentModel model;
  const AttachmentCreateEvent({
    required this.model,
  });
}
class AttachmentUpdateEvent extends AttachmentEvent {
  final UpdateAttachmentModel model;
  const AttachmentUpdateEvent({
    required this.model,
  });
}

class AttachmentLoadEvent extends AttachmentEvent {
  final ShowMessage showMessage;
  final DataSource dataSource;
  final Function(LoadingMoreEvent)? onDone;
  final AttachmentsFilterModel filters;
  final bool empty;
  final bool refresh;
  const AttachmentLoadEvent(
      {required this.filters,
      this.onDone,
      this.empty = false,     
       this.refresh = false,

      this.showMessage = ShowMessage.none,
      this.dataSource = DataSource.remote});
  @override
  List<Object?> get props => [dataSource, filters, showMessage, empty];
}
