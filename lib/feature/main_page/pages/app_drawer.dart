import 'package:app/core/shared/imports.dart';
import 'package:app/feature/account/presentation/views/profiles_widgets.dart';
import 'package:app/feature/stock/presentation/view/pages/stock_screen.dart';
import 'package:app/feature/main_page/bloc/tabs_bloc.dart';
import 'package:app/startup/onboarding/page/langguage_screen.dart';
import 'package:app/widgets/app_version_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        bottomNavigationBar: const AppVersionWidget(),
        backgroundColor: context.cardColor,
        body: ListView(
          children: [
            const SizedBox(height: 50),
            const DrawerProfileWidget(),
            const SizedBox(height: 40),
            const SizedBox(height: 0),
            DrawerBtn(
              icon: Icons.dashboard,
              screen: Screens.home,
              title: Trans.home.trans(context: context),
            ),
            DrawerBtn(
              icon: Icons.payments,
              screen: Screens.payments,
              title: Trans.payments.trans(context: context),
            ),
            DrawerBtn(
              icon: Icons.toll_rounded,
              screen: Screens.payInsteads,
              title: Trans.payInsteads.trans(context: context),
            ),
            DrawerBtn(
              icon: Icons.payments_outlined,
              screen: Screens.payReturns,
              title: Trans.payReturns.trans(context: context),
            ),
            DrawerBtn(
              icon: Icons.attachment,
              screen: Screens.attachments,
              title: Trans.attachments.trans(context: context),
            ),
            DrawerBtn(
              icon: Icons.line_axis,
              screen: Screens.customerDoubleEntries,
              title: Trans.customerDoubleEntries.trans(context: context),
            ),
            DrawerBtn(
              icon: Icons.shopping_bag_sharp,
              screen: Screens.packages,
              title: Trans.packages.trans(context: context),
            ),
            DrawerBtn(
              icon: Icons.inventory_2_outlined,
              screen: Screens.stock,
              title: Trans.stockTitle.trans(context: context),
              onTap: () {
                context.pop();
                context.to(const StockScreen());
              },
            ),
            DrawerBtn(
              icon: Icons.search_outlined,
              screen: Screens.container,
              title: Trans.container.trans(context: context),
            ),
            if (appConfig.isRbb)
              DrawerBtn(
                icon: Icons.track_changes_outlined,
                screen: Screens.trackContainer,
                title: Trans.trackContainer.trans(context: context),
              ),
            if (kDebugMode)
              DrawerBtn(
                icon: Icons.explore,
                screen: Screens.containerExpenses,
                title: Trans.containerExpenses.trans(context: context),
              ),
            DrawerBtn(
                icon: Icons.language_outlined,
                screen: Screens.language,
                title: Trans.language.trans(context: context),
                onTap: () {
                  showChangeLang();
                }),
            DrawerBtn(
                icon: Icons.light,
                screen: Screens.theme,
                title: Trans.theme.trans(context: context),
                onTap: () {
                  showChangeTheme();
                }),
            const SizedBox(height: 0),
            DrawerBtn(
                iconColor: Colors.red,
                icon: Icons.logout,
                screen: Screens.logOut,
                title: Trans.logOut.trans(context: context),
                onTap: () {
                  signOut(showConfirm: true);
                }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class DrawerBtn extends StatelessWidget {
  const DrawerBtn(
      {super.key,
      required this.title,
      this.onTap,
      required this.screen,
      this.iconColor,
      this.icon});
  final String title;
  final Screens screen;
  final Color? iconColor;
  final IconData? icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final selected = sl<TabsBloc>().state.screen;
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 20),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          context.pop();

          if (onTap != null) {
            onTap?.call();
          } else {
            sl<TabsBloc>().setPage(screen);
          }
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadiusDirectional.only(
                  topEnd: Radius.circular(45), bottomEnd: Radius.circular(45)),
              color: selected == screen ? context.primaryColor : null),
          padding: const EdgeInsetsDirectional.only(
            start: 20,
            end: 16,
            top: 12,
            bottom: 12,
          ),
          child: Row(
            children: [
              Icon(icon,
                  size: 24,
                  color: iconColor ??
                      (selected == screen
                          ? Colors.white
                          : context.primaryColor)),
              const SizedBox(width: 16),
              Text(title,
                  style: context.style16W500B.copyWith(
                      color: iconColor ??
                          (selected == screen
                              ? Colors.white
                              : context.style16W500B.color),
                      fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}
