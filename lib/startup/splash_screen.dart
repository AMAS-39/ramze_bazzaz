import 'package:app/core/shared/imports.dart';
import 'package:app/feature/account/presentation/bloc/account/account_bloc.dart';
import 'package:app/feature/account/presentation/views/login_screen.dart';
import 'package:app/feature/main_page/pages/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    reInitRegisterBlocs();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });

    super.initState();
  }

  Future<void> init() async {
    sl<ConnectionCubit>().startListen();
    sl<AccountBloc>().add(const AccountFromLocalEvent());
    await Future.delayed(const Duration(seconds: 2));
    _nextScreen();
  }

  Future<void> _nextScreen() async {
    late Widget child;
    logger("_nextScreen");

    if (sl<AccountBloc>().info != null) {
      child = const MainTabsScreen();
    } else {
      child = const LoginScreen(isFromTabScreen: false);
    }

    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (_) => child), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context, designSize: const Size(430, 932));
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(alignment: Alignment.center, children: [
          Center(
            child:  Image.asset(appConfig.logo, width: 300.w, height: 300.w),
          ),
        ]));
  }
}
