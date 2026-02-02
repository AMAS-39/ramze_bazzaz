part of 'slides_bloc.dart';

class SlideEvent extends Equatable {
  const SlideEvent();

  @override
  List<Object?> get props => [];
}

class SlideEmptyEvent extends SlideEvent {
  const SlideEmptyEvent();
}



class SlideDeleteEvent extends SlideEvent {
  final SlideModel model;
  const SlideDeleteEvent(this.model);
}

class SlideCreateEvent extends SlideEvent {
  final CreateSlideModel model;
  const SlideCreateEvent({
    required this.model,
  });
}
class SlideUpdateEvent extends SlideEvent {
  final UpdateSlideModel model;
  const SlideUpdateEvent({
    required this.model,
  });
}

class SlideLoadEvent extends SlideEvent {
  final ShowMessage showMessage;
  final DataSource dataSource;
  final Function(LoadingMoreEvent)? onDone;
  final SlidesFilterModel filters;
  final bool empty;
  final bool refresh;
  const SlideLoadEvent(
      {required this.filters,
      this.onDone,
      this.empty = false,     
       this.refresh = false,

      this.showMessage = ShowMessage.none,
      this.dataSource = DataSource.remote});
  @override
  List<Object?> get props => [dataSource, filters, showMessage, empty];
}
