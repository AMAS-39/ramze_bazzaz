import 'package:app/core/shared/imports.dart';
import 'package:app/feature/app_setting/persentation/bloc/local_setting/local_app_setting_cubit.dart';
import 'package:app/feature/attachments/data/models/attachments_filter.dart';
import 'package:app/feature/attachments/presentation/view/pages/attachments_screen.dart';
import 'package:app/feature/container_expenses/data/models/container_expenses_filter.dart';
import 'package:app/feature/container_expenses/presentation/view/pages/container_expenses_screen.dart';
import 'package:app/feature/containers/presentation/view/pages/search_container_screen.dart';
import 'package:app/feature/containers/presentation/view/pages/track_container_screen.dart';
import 'package:app/feature/customer_double_entrys/data/models/customer_double_entrys_filter.dart';
import 'package:app/feature/customer_double_entrys/presentation/view/pages/customer_double_entrys_screen.dart';
import 'package:app/feature/main_page/bloc/tabs_bloc.dart';
import 'package:app/feature/main_page/pages/app_drawer.dart';
import 'package:app/feature/main_page/pages/bottom_bar.dart';
import 'package:app/feature/main_page/pages/setting_screen.dart';
import 'package:app/feature/packages/data/models/packages_filter.dart';
import 'package:app/feature/packages/presentation/view/pages/packages_screen.dart';
import 'package:app/feature/pay_insteads/data/models/pay_insteads_filter.dart';
import 'package:app/feature/pay_insteads/presentation/view/pages/pay_insteads_screen.dart';
import 'package:app/feature/pay_insteads/presentation/view/pages/pay_returns_screen.dart';
import 'package:app/feature/payments/data/models/payments_filter.dart';
import 'package:app/feature/payments/presentation/view/pages/payments_screen.dart';
import 'package:app/feature/stock/presentation/view/pages/stock_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dash_board.dart';

class RbbTabScreen extends StatefulWidget {
  const RbbTabScreen({super.key});
  @override
  State<RbbTabScreen> createState() => _RbbTabScreenState();
}

class _RbbTabScreenState extends State<RbbTabScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocConsumer<TabsBloc, TabPageState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(state.screen.name.trans(context: context)),
              ),
              drawer: const AppDrawer(),
              body: {
                Screens.home: const DashBoard(),
                Screens.payments: const PaymentsScreen(
                    filterController: PaymentsFilterModel(setNumber: firstSet)),
                Screens.payInsteads: const PayInsteadsScreen(
                    filterController: PayInsteadsFilterModel(
                        setNumber: firstSet, isLost: true)),
                Screens.payReturns: const PayReturnsScreen(
                    filterController: PayInsteadsFilterModel(
                        setNumber: firstSet, isLost: false)),
                Screens.attachments: const AttachmentsScreen(
                    filterController:
                        AttachmentsFilterModel(setNumber: firstSet)),
                Screens.packages: const PackagesScreen(
                    filterController: PackagesFilterModel(setNumber: firstSet)),
                Screens.stock: const StockScreen(),
                Screens.container: const SearchForContainerScreen(),
                Screens.trackContainer: const TrackContainerScreen(),
                Screens.containerExpenses: const ContainerExpensesScreen(
                  filterController:
                      ContainerExpensesFilterModel(setNumber: firstSet),
                ),
                Screens.customerDoubleEntries: const CustomerDoubleEntrysScreen(
                  filterController:
                      CustomerDoubleEntrysFilterModel(setNumber: firstSet),
                ),
              }[state.screen],
            );
          }),
    );
  }

  @override
  void initState() {
    sl<TabsBloc>().setPage(Screens.home);

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      sl<LocalAppSettingsCubit>().changeShowIntro(false);
    });
    super.initState();
  }
}

class MainTabsScreen extends StatefulWidget {
  const MainTabsScreen({super.key});

  @override
  State<MainTabsScreen> createState() => _MainTabsScreenState();
}

class _MainTabsScreenState extends State<MainTabsScreen> {
  @override
  Widget build(BuildContext context) {
    if (appConfig.app == App.rbb) {
      return const RbbTabScreen();
    } else {
      return const OtherTabScreen();
    }
  }
}

class OtherTabScreen extends StatefulWidget {
  const OtherTabScreen({super.key});
  @override
  State<OtherTabScreen> createState() => _OtherTabScreenState();
}

class _OtherTabScreenState extends State<OtherTabScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocConsumer<TabsBloc, TabPageState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              bottomNavigationBar: const CustomBottomBar(),
              // drawer: const AppDrawer(),
              appBar: AppBar(
                title: Text(state.screen.name.trans(context: context)),
              ),
              body: {
                Screens.home: const DashBoard(),
                Screens.payments: const PaymentsScreen(
                    filterController: PaymentsFilterModel(setNumber: firstSet)),
                Screens.payInsteads: const PayInsteadsScreen(
                    filterController: PayInsteadsFilterModel(
                        setNumber: firstSet, isLost: true)),
                Screens.payReturns: const PayReturnsScreen(
                    filterController: PayInsteadsFilterModel(
                        setNumber: firstSet, isLost: false)),
                Screens.attachments: const AttachmentsScreen(
                    filterController:
                        AttachmentsFilterModel(setNumber: firstSet)),
                Screens.packages: const PackagesScreen(
                    filterController: PackagesFilterModel(setNumber: firstSet)),
                Screens.stock: const StockScreen(),
                Screens.container: const SearchForContainerScreen(),
                Screens.trackContainer: const TrackContainerScreen(),
                Screens.settings: const SettingScreen(),
                Screens.containerExpenses: const ContainerExpensesScreen(
                    filterController:
                        ContainerExpensesFilterModel(setNumber: firstSet)),
              }[state.screen],
            );
          }),
    );
  }

  @override
  void initState() {
    sl<TabsBloc>().setPage(Screens.home);

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      sl<LocalAppSettingsCubit>().changeShowIntro(false);
    });
    super.initState();
  }
}
