part of 'containers_bloc.dart';

class ContainerEvent extends Equatable {
  const ContainerEvent();

  @override
  List<Object?> get props => [];
}

class ContainerEmptyEvent extends ContainerEvent {
  const ContainerEmptyEvent();
}



class ContainerDeleteEvent extends ContainerEvent {
  final ContainerModel model;
  const ContainerDeleteEvent(this.model);
}

class ContainerCreateEvent extends ContainerEvent {
  final CreateContainerModel model;
  const ContainerCreateEvent({
    required this.model,
  });
}
class ContainerUpdateEvent extends ContainerEvent {
  final UpdateContainerModel model;
  const ContainerUpdateEvent({
    required this.model,
  });
}

class ContainerLoadEvent extends ContainerEvent {
  final ShowMessage showMessage;
  final DataSource dataSource;
  final Function(LoadingMoreEvent)? onDone;
  final ContainersFilterModel filters;
  final bool empty;
  final bool refresh;
  const ContainerLoadEvent(
      {required this.filters,
      this.onDone,
      this.empty = false,     
       this.refresh = false,

      this.showMessage = ShowMessage.none,
      this.dataSource = DataSource.remote});
  @override
  List<Object?> get props => [dataSource, filters, showMessage, empty];
}
