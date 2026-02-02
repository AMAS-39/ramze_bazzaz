part of 'tabs_bloc.dart';

class TabPageState extends Equatable {
  final Screens screen;
  const TabPageState({required this.screen});

  @override
  List<Object?> get props => [screen];
}
