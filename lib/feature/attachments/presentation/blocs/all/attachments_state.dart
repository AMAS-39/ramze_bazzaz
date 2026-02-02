part of 'attachments_bloc.dart';

abstract class AttachmentsState extends Equatable {
  bool get loadIsNot {
    return items.isEmpty && this is! AttachmentsLoadingState;
  }

  List<AttachmentModel> get items {
    if (this is AttachmentsLoadedState) {
      return (this as AttachmentsLoadedState).data;
    }
    return <AttachmentModel>[];
  }

  const AttachmentsState({this.metaModel = const MetaModel()});
  @override
  List<Object> get props => [];
  final MetaModel metaModel;

  @override
  String toString() => 'AttachmentState(metaModel: $metaModel)';
}

class AttachmentInitialState extends AttachmentsState {
  @override
  List<Object> get props => [];
}

class AttachmentsLoadingState extends AttachmentsState {
  @override
  List<Object> get props => [];
}

class AttachmentsLoadedState extends AttachmentsState {
  final List<AttachmentModel> data;
  const AttachmentsLoadedState({
    required this.data,
    required super.metaModel,
  });
  @override
  List<Object> get props => [data, metaModel, randomInt];

  AttachmentsLoadedState copyWith(
      {List<AttachmentModel>? data, MetaModel? metaModel}) {
    return AttachmentsLoadedState(
      metaModel: metaModel ?? this.metaModel,
      data: data ?? this.data,
    );
  }

  @override
  String toString() =>
      'AttachmentLoadedState(data: $data ,metaModel:$metaModel)';
}

class AttachmentsEmptyState extends AttachmentsState {
  const AttachmentsEmptyState();
  @override
  List<Object> get props => [];
}

class AttachmentsErrorState extends AttachmentsState {
  final Failure failure;
  const AttachmentsErrorState({required this.failure});
  @override
  List<Object> get props => [failure];
}
