part of 'attachment_bloc.dart';

abstract class OneAttachmentState extends Equatable {
  const OneAttachmentState();
  @override
  List<Object?> get props => [];
}

class OneAttachmentInitialState extends OneAttachmentState {
  @override
  List<Object?> get props => [];
}

class OneAttachmentLoadingState extends OneAttachmentState {
  @override
  List<Object?> get props => [];
}

class OneAttachmentLoadedState extends OneAttachmentState {
  final AttachmentDetailsModel data;
  const OneAttachmentLoadedState({this.failure, required this.data});
  final Failure? failure;
  @override
  List<Object?> get props => [data, failure, DateTime.now()];
}

class OneAttachmentEmptyState extends OneAttachmentState {
  const OneAttachmentEmptyState();

  @override
  List<Object> get props => [];
}

class OneAttachmentErrorState extends OneAttachmentState {
  final Failure failure;
  const OneAttachmentErrorState({required this.failure});
  @override
  List<Object> get props => [failure];
}
