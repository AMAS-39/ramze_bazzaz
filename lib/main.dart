import 'dart:io';

import 'package:app/core/shared/imports.dart';
import 'package:app/feature/account/presentation/bloc/account/account_bloc.dart';
import 'package:app/feature/account/presentation/bloc/customer_info/customer_info_bloc.dart';
import 'package:app/feature/app_setting/data/model/local_app_setting.dart';
import 'package:app/feature/app_setting/persentation/bloc/local_setting/local_app_setting_cubit.dart';
import 'package:app/feature/attachments/presentation/blocs/all/attachments_bloc.dart';
import 'package:app/feature/container_expenses/presentation/blocs/all/container_expenses_bloc.dart';
import 'package:app/feature/containers/presentation/blocs/all/containers_bloc.dart';
import 'package:app/feature/customer_double_entrys/presentation/blocs/all/customer_double_entrys_bloc.dart';
import 'package:app/feature/main_page/bloc/tabs_bloc.dart';
import 'package:app/feature/notifications/presentation/blocs/all/notifications_bloc.dart';
import 'package:app/feature/packages/presentation/blocs/all/packages_bloc.dart';
import 'package:app/feature/pay_insteads/presentation/blocs/all/pay_insteads_bloc.dart';
import 'package:app/feature/payments/presentation/blocs/all/payments_bloc.dart';
import 'package:app/feature/slides/presentation/blocs/all/slides_bloc.dart';
import 'package:app/localization/localization_constansts.dart';
import 'package:app/startup/splash_screen.dart';
import 'package:app/theme/dark_theme.dart';
import 'package:app/theme/light_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final res = await PackageInfo.fromPlatform();
  logger("fromEnvironment ${res.packageName}");
  if (res.packageName.contains("kostolog")) {
    appConfig = Apps.kostolog;
  } else {
    appConfig = Apps.rbb;
  }

  logger("=== BASE URL: ${appConfig.url} ===");
  logger("=== API BASE URL: ${appConfig.url}/api/ClientSide ===");
  logger("=== APP CONFIG: ${appConfig.appName} (${appConfig.app.name}) ===");

  await initInjection();
  try {
    Firebase.initializeApp(options: appConfig.fireabse.currentPlatform);
  } catch (e, c) {
    logger("e $e");
    recoredError(e, c);
  }
  if (!kDebugMode && !kIsWeb) {
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance
          .recordError(errorDetails.exception, errorDetails.stack);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack);
      return true;
    };
  }
  runApp(const Blocs());
}

class Blocs extends StatelessWidget {
  const Blocs({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<TabsBloc>(create: (BuildContext context) => sl<TabsBloc>()),
      BlocProvider<SlidesBloc>(
          create: (BuildContext context) => sl<SlidesBloc>()),
      BlocProvider<ContainerExpensesBloc>(
          create: (BuildContext context) => sl<ContainerExpensesBloc>()),
      BlocProvider<NotificationsBloc>(
          create: (BuildContext context) => sl<NotificationsBloc>()),
      BlocProvider<ContainersBloc>(
          create: (BuildContext context) => sl<ContainersBloc>()),
      BlocProvider<AttachmentsBloc>(
          create: (BuildContext context) => sl<AttachmentsBloc>()),
      BlocProvider<PayInsteadsBloc>(
          create: (BuildContext context) => sl<PayInsteadsBloc>()),
      BlocProvider<PayReturnBloc>(
          create: (BuildContext context) => sl<PayReturnBloc>()),
      BlocProvider<PackagesBloc>(
          create: (BuildContext context) => sl<PackagesBloc>()),
      BlocProvider<PaymentsBloc>(
          create: (BuildContext context) => sl<PaymentsBloc>()),
      BlocProvider<ConnectionCubit>(
          create: (BuildContext context) => sl<ConnectionCubit>()),
      BlocProvider<LocalAppSettingsCubit>(
          create: (BuildContext context) => sl<LocalAppSettingsCubit>()),
      BlocProvider<AccountBloc>(
          create: (BuildContext context) => sl<AccountBloc>()),
      BlocProvider<CustomerDoubleEntrysBloc>(
          create: (BuildContext context) => sl<CustomerDoubleEntrysBloc>()),
      BlocProvider<CustomerInfoBloc>(
          create: (BuildContext context) => sl<CustomerInfoBloc>()),
    ], child: const _MyApp());
  }
}

class _MyApp extends StatelessWidget {
  const _MyApp();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return BlocConsumer<LocalAppSettingsCubit, LocalAppSettingsState>(
      listener: (context, state) {},
      builder: (context, state) {
        logger("state.lang ${state.lang}");
        return OverlaySupport.global(
          key: ValueKey(state.lang),
          child: MaterialApp(
            onGenerateTitle: (BuildContext context) {
              return appConfig.appName;
            },
            localizationsDelegates: localizationsDelegates,
            debugShowCheckedModeBanner: false,
            // themeMode: ThemeMode.dark,
            // themeMode: ThemeMode.dark,
            themeMode: state.themeMode,
            theme: getLightTheme(),
            darkTheme: getDarkTheme(),
            navigatorObservers: [AppNavigatorObserver()],

            home: const SplashScreen(),
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.1)),
                child: Material(
                  child: InkWell(
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      closeKeyBoard(Helper.i.context);
                    },
                    child: child ?? const SizedBox(),
                  ),
                ),
              );
            },
            scrollBehavior: kIsWeb
                ? null
                : Platform.isAndroid
                    ? MyCustomScrollBehavior()
                    : null,
            navigatorKey: Helper.i.navigatorKey,
            supportedLocales: supportedLocales,
            locale: getLocale(state.lang),
            // locale: getLocale("en"),
          ),
        );
      },
    );
  }
}

class AppNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    closeKeyBoard(Helper.i.context);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    closeKeyBoard(Helper.i.context);
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return StretchingOverscrollIndicator(
      axisDirection: details.direction,
      clipBehavior: details.decorationClipBehavior ?? Clip.hardEdge,
      child: child,
    );
  }
}
