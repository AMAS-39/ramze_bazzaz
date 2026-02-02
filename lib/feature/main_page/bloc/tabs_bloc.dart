import 'package:app/core/shared/imports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tabs_state.dart';

class TabsBloc extends Cubit<TabPageState> {
  TabsBloc() : super(const TabPageState(screen: Screens.home));

  void setPage(Screens screenEnums) {
    emit(TabPageState(screen: screenEnums));
  }
}
