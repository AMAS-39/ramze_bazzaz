part of 'package_bloc.dart';

abstract class OnePackageEvent extends Equatable {
  const OnePackageEvent();

  @override
  List<Object> get props => [];
}

class OnePackageGetEvent extends OnePackageEvent {
  final Map<String, String> params;
  final ShowMessage showMessage;
  final DataSource dataSource;
  final  int id;

  const OnePackageGetEvent(
      {required this.id,
      this.params = const {},
      this.showMessage = ShowMessage.none,
      this.dataSource = DataSource.remote})
      : super();
  @override
  @override
  List<Object> get props => [dataSource, params, showMessage];
}

class OnePackageRefreshEvent extends OnePackageEvent {
  final Map<String, String> params;
  final ShowMessage showMessage;
  final DataSource dataSource;
  final  int id;
  const OnePackageRefreshEvent(
      {required this.id,
      this.params = const {},
      this.showMessage = ShowMessage.none,
      this.dataSource = DataSource.remote});
  @override
  List<Object> get props => [dataSource, params, showMessage];
}
