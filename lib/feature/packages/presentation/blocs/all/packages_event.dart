part of 'packages_bloc.dart';

class PackageEvent extends Equatable {
  const PackageEvent();

  @override
  List<Object?> get props => [];
}

class PackageEmptyEvent extends PackageEvent {
  const PackageEmptyEvent();
}



class PackageDeleteEvent extends PackageEvent {
  final PackageModel model;
  const PackageDeleteEvent(this.model);
}

class PackageCreateEvent extends PackageEvent {
  final CreatePackageModel model;
  const PackageCreateEvent({
    required this.model,
  });
}
class PackageUpdateEvent extends PackageEvent {
  final UpdatePackageModel model;
  const PackageUpdateEvent({
    required this.model,
  });
}

class PackageLoadEvent extends PackageEvent {
  final ShowMessage showMessage;
  final DataSource dataSource;
  final Function(LoadingMoreEvent)? onDone;
  final PackagesFilterModel filters;
  final bool empty;
  final bool refresh;
  const PackageLoadEvent(
      {required this.filters,
      this.onDone,
      this.empty = false,     
       this.refresh = false,

      this.showMessage = ShowMessage.none,
      this.dataSource = DataSource.remote});
  @override
  List<Object?> get props => [dataSource, filters, showMessage, empty];
}
