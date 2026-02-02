import 'package:app/core/shared/imports.dart';
import 'package:app/feature/main_page/bloc/tabs_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    List<BottomMenuModel> bottomMenuList = [
      BottomMenuModel(
        screen: Screens.home,
        tooltip: Trans.home.trans(),
        icon: Icons.home,
        activeIcon: Icons.home,
      ),
      BottomMenuModel(
        screen: Screens.payments,
        tooltip: Trans.payments.trans(),
        icon: Icons.payments,
        activeIcon: Icons.payments,
      ),
      BottomMenuModel(
        screen: Screens.container,
        tooltip: Trans.container.trans(),
        icon: Icons.search,
        activeIcon: Icons.search,
      ),
      BottomMenuModel(
        screen: Screens.containerExpenses,
        tooltip: Trans.containerExpenses.trans(),
        icon: Icons.explore,
        activeIcon: Icons.explore,
      ),
      BottomMenuModel(
        screen: Screens.settings,
        tooltip: Trans.settings.trans(),
        icon: Icons.settings,
        activeIcon: Icons.settings,
      )
    ];

    return BlocBuilder<TabsBloc, TabPageState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(color: context.cardColor),
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: bottomMenuList.map((e) {
                        return Tooltip(
                          message: e.tooltip,
                          preferBelow: false,
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(360),
                                onTap: () {
                                  sl<TabsBloc>().setPage(e.screen);
                                },
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        e.icon,
                                        size: 26,
                                        color: state.screen == (e.screen)
                                            ? context.primaryColor
                                            : Colors.grey,
                                      ),
                                      if (state.screen == (e.screen))
                                        Container(
                                          height: 4,
                                          width: 4,
                                          margin: const EdgeInsets.only(top: 4),
                                          decoration: BoxDecoration(
                                            color: context.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList())),
            ),
          ],
        );
      },
    );
  }
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    required this.tooltip,
    required this.screen,
  });

  final IconData activeIcon;
  final IconData icon;
  final Screens screen;
  final String tooltip;
}
