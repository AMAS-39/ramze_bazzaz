// ignore_for_file: use_build_context_synchronously
import 'package:app/core/shared/imports.dart';
import 'package:app/feature/account/presentation/bloc/account/account_bloc.dart';
import 'package:app/startup/onboarding/page/langguage_screen.dart';
import 'package:app/widgets/title_with_arrow.dart';
import 'package:flutter/material.dart';

Future<void> showSettingModal() async {
  return await showModalBottomSheet(
      context: Helper.i.context,
      shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(BORDER_RADUIS),
              topRight: Radius.circular(BORDER_RADUIS))),
      builder: (context) {
        return const __NewWidget();
      });
}

class __NewWidget extends StatelessWidget {
  const __NewWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 75,
            height: 8,
            decoration: BoxDecoration(
                color: context.primaryColor,
                borderRadius: BorderRadius.circular(BORDER_RADUIS)),
          ),
          const SizedBox(height: 20),
          TitleWithArrow(
              title: Trans.language.trans(),
              onTap: () {
                showChangeLang();
              }),
          TitleWithArrow(
              color: Colors.red,
              icon: Icons.logout,
              title: Trans.logOut.trans(),
              onTap: () {
                sl<AccountBloc>()
                    .add(const AccountLogoutEvent(showConfirm: true));
              })
        ],
      ),
    );
  }
}
