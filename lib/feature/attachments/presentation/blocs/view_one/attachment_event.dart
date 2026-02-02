part of 'attachment_bloc.dart';

abstract class OneAttachmentEvent extends Equatable {
  const OneAttachmentEvent();

  @override
  List<Object> get props => [];
}

class OneAttachmentGetEvent extends OneAttachmentEvent {
  final Map<String, String> params;
  final ShowMessage showMessage;
  final DataSource dataSource;
  final  int id;

  const OneAttachmentGetEvent(
      {required this.id,
      this.params = const {},
      this.showMessage = ShowMessage.none,
      this.dataSource = DataSource.remote})
      : super();
  @override
  @override
  List<Object> get props => [dataSource, params, showMessage];
}

class OneAttachmentRefreshEvent extends OneAttachmentEvent {
  final Map<String, String> params;
  final ShowMessage showMessage;
  final DataSource dataSource;
  final  int id;
  const OneAttachmentRefreshEvent(
      {required this.id,
      this.params = const {},
      this.showMessage = ShowMessage.none,
      this.dataSource = DataSource.remote});
  @override
  List<Object> get props => [dataSource, params, showMessage];
}
