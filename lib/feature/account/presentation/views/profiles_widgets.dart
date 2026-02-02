import 'package:app/core/shared/imports.dart';
import 'package:app/feature/account/presentation/bloc/account/account_bloc.dart';
import 'package:app/startup/onboarding/page/setting_modal.dart';
import 'package:app/widgets/image_cheker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingProfileWidget extends StatefulWidget {
  const SettingProfileWidget({super.key});

  @override
  State<SettingProfileWidget> createState() => _SettingProfileWidgetState();
}

class _SettingProfileWidgetState extends State<SettingProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        logger("sl<AccountBloc>().info ${sl<AccountBloc>().info}");
        return Row(
          children: [
            ImageChecker(
              height: 65,
              width: 65,
              radius: 360,
              imageUrl: sl<AccountBloc>().info?.image,
              errorImage: appConfig.logo,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    sl<AccountBloc>().info?.fullName ?? "",
                    style: context.style20W600B,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    (sl<AccountBloc>().info?.email ?? ""),
                    style: context.style12W400,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class DrawerProfileWidget extends StatefulWidget {
  const DrawerProfileWidget({super.key});

  @override
  State<DrawerProfileWidget> createState() => _DrawerProfileWidgetState();
}

class _DrawerProfileWidgetState extends State<DrawerProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        logger("sl<AccountBloc>().info ${sl<AccountBloc>().info}");
        return Column(
          children: [
            SizedBox(
              width: DrawerTheme.of(context).width ?? context.width,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  ImageChecker(
                    height: 100,
                    width: 100,
                    radius: 360,
                    imageUrl: sl<AccountBloc>().info?.image,
                    errorImage: appConfig.logo,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Column(
              children: [
                Text(
                  sl<AccountBloc>().info?.fullName ?? "",
                  style: context.style20W600B,
                ),
                const SizedBox(height: 4),
                Text(
                  (sl<AccountBloc>().info?.email ?? ""),
                  style: context.style12W400,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class HomeProfile extends StatefulWidget {
  const HomeProfile({super.key});

  @override
  State<HomeProfile> createState() => _HomeProfileState();
}

class _HomeProfileState extends State<HomeProfile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        logger("sl<AccountBloc>().info ${sl<AccountBloc>().info}");
        return Padding(
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      sl<AccountBloc>().info?.fullName ?? "",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: context.titleStyle.color),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      (sl<AccountBloc>().info?.expiration?.onlyDate ?? ""),
                      style: context.style12W400,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              InkWell(
                  onTap: () {
                    showSettingModal();
                  },
                  child: const Icon(Icons.settings))
            ],
          ),
        );
      },
    );
  }
}
