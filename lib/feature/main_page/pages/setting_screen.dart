import 'dart:io';

import 'package:app/core/shared/imports.dart';
import 'package:app/feature/account/presentation/bloc/account/account_bloc.dart';
import 'package:app/feature/account/presentation/views/profiles_widgets.dart';
import 'package:app/feature/attachments/data/models/attachments_filter.dart';
import 'package:app/feature/attachments/presentation/view/pages/attachments_screen.dart';
import 'package:app/feature/stock/presentation/view/pages/stock_screen.dart';
import 'package:app/feature/main_page/bloc/tabs_bloc.dart';
import 'package:app/feature/packages/data/models/packages_filter.dart';
import 'package:app/feature/packages/presentation/view/pages/packages_screen.dart';
import 'package:app/feature/pay_insteads/data/models/pay_insteads_filter.dart';
import 'package:app/feature/pay_insteads/presentation/view/pages/pay_insteads_screen.dart';
import 'package:app/feature/pay_insteads/presentation/view/pages/pay_returns_screen.dart';
import 'package:app/startup/onboarding/page/langguage_screen.dart';
import 'package:app/widgets/app_version_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const AppVersionWidget(),
      backgroundColor: context.cardColor,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 32),
          const SettingProfileWidget(),
          const Divider(),
          DrawerBtn(
            onTap: () {
              context.to(const PackagesScreen(
                  filterController: PackagesFilterModel(setNumber: firstSet)));
            },
            icon: Icons.shopping_bag_sharp,
            screen: Screens.packages,
            title: Trans.packages.trans(context: context),
          ),
          const Divider(),
          DrawerBtn(
            onTap: () {
              context.to(const StockScreen());
            },
            icon: Icons.inventory_2_outlined,
            screen: Screens.stock,
            title: Trans.stockTitle.trans(context: context),
          ),
          const Divider(),
          DrawerBtn(
            onTap: () {
              context.to(const PayInsteadsScreen(
                  filterController: PayInsteadsFilterModel(
                      setNumber: firstSet, isLost: true)));
            },
            icon: Icons.toll_rounded,
            screen: Screens.payInsteads,
            title: Trans.payInsteads.trans(context: context),
          ),
          const Divider(),
          DrawerBtn(
            onTap: () {
              context.to(const PayReturnsScreen(
                  filterController: PayInsteadsFilterModel(
                      setNumber: firstSet, isLost: false)));
            },
            icon: Icons.payments_outlined,
            screen: Screens.payReturns,
            title: Trans.payReturns.trans(context: context),
          ),
          const Divider(),
          DrawerBtn(
            onTap: () {
              context.to(
                const AttachmentsScreen(
                    filterController:
                        AttachmentsFilterModel(setNumber: firstSet)),
              );
            },
            icon: Icons.attachment,
            screen: Screens.attachments,
            title: Trans.attachment.trans(context: context),
          ),
          const Divider(),
          // DrawerBtn(
          //   onTap: () {
          //     context.to(
          //       const CustomerDoubleEntrysScreen(
          //           filterController:
          //               CustomerDoubleEntrysFilterModel(setNumber: firstSet)),
          //     );
          //   },
          //   icon: Icons.report,
          //   screen: Screens.customerDoubleEntries,
          //   title: Trans.customerDoubleEntries.trans(context: context),
          // ),
          //           const Divider(),
          DrawerBtn(
              icon: Icons.language_outlined,
              screen: Screens.language,
              title: Trans.language.trans(context: context),
              onTap: () {
                showChangeLang();
              }),
          const Divider(),
          DrawerBtn(
              icon: Icons.light,
              screen: Screens.theme,
              title: Trans.theme.trans(context: context),
              onTap: () {
                showChangeTheme();
              }),
          const Divider(),
          if ((appConfig.app == App.kostolog &&
              ((kIsWeb || Platform.isIOS) || kDebugMode))) ...[
            DrawerBtn(
                icon: Icons.delete,
                screen: Screens.theme,
                iconColor: Colors.red,
                title: Trans.deleteAccount.trans(context: context),
                onTap: () {
                  sl<AccountBloc>().add(AccountDeleteEvent());
                }),
            const Divider()
          ],
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
