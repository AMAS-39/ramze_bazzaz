import 'package:app/core/data_source/remote_data_source/remote_data_source_abs.dart';
import 'package:app/core/data_source/remote_data_source/remote_data_source_impl.dart';
import 'package:app/core/network_checker/connection_checker.dart';
import 'package:app/core/shared/imports.dart';
import 'package:app/feature/account/data/datasources/account_local_data_source.dart';
import 'package:app/feature/account/data/datasources/account_remote_data_source.dart';
import 'package:app/feature/account/data/repo/account_repo.dart';
import 'package:app/feature/account/presentation/bloc/account/account_bloc.dart';
import 'package:app/feature/account/presentation/bloc/customer_info/customer_info_bloc.dart';
import 'package:app/feature/app_setting/data/data_source/app_setting_local_data.dart';
import 'package:app/feature/app_setting/data/data_source/setting_local_data.dart';
import 'package:app/feature/app_setting/data/data_source/setting_remote_data.dart';
import 'package:app/feature/app_setting/data/data_source/setting_repo.dart';
import 'package:app/feature/app_setting/persentation/bloc/local_setting/local_app_setting_cubit.dart';
import 'package:app/feature/attachments/attachment.dart';
import 'package:app/feature/container_expenses/container_expense.dart';
import 'package:app/feature/containers/container.dart';
import 'package:app/feature/customer_double_entrys/customer_double_entry.dart';
import 'package:app/feature/main_page/bloc/tabs_bloc.dart';
import 'package:app/feature/notifications/notification.dart';
import 'package:app/feature/packages/package.dart';
import 'package:app/feature/pay_insteads/pay_instead.dart';
import 'package:app/feature/payments/payment.dart';
import 'package:app/feature/slides/slide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future initInjection() async {
  //!LocalAppSettings
  sl.registerLazySingleton<LocalAppSettingsRepo>(() => LocalAppSettingsRepo());
  await sl<LocalAppSettingsRepo>().initData();
  // !ConnectionChecker
  sl.registerLazySingleton<ConnectionChecker>(() => ConnectionCheckerImpl());
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  //!LocalNotificationServices

  sl.registerLazySingleton<LocalAppSettingsCubit>(() => LocalAppSettingsCubit(
        localAppSettings: sl(),
      ));
  sl.registerLazySingleton<ConnectionCubit>(
      () => ConnectionCubit(connectionChecker: sl()));

  sl.registerLazySingleton<TabsBloc>(() => TabsBloc());
  //! Login and Accounts
  sl.registerLazySingleton<RemoteDataSourceAbs>(() => RemoveDataSourceImp());
  sl.registerLazySingleton<AccountLocalSrc>(() => AccountLocalSrc());
  sl<AccountLocalSrc>().init();
  sl.registerLazySingleton<AccountRepo>(() => AccountRepo(
      localAccountSrc: sl(), connectionChecker: sl(), accountRemoteSrc: sl()));
  sl.registerLazySingleton<AccountRemoteSrc>(
      () => AccountRemoteSrc(networkOperation: sl()));
  sl.registerLazySingleton<AccountBloc>(() => AccountBloc(repository: sl()));
  sl.registerLazySingleton<CustomerInfoBloc>(
      () => CustomerInfoBloc(repository: sl()));

  //! Settings and check version
  sl.registerLazySingleton<SettingsRemoteSrcRepo>(
      () => SettingsRemoteSrcRepo());
  sl.registerLazySingleton<SettingsLocalSrcRepo>(() => SettingsLocalSrcRepo());
  sl.registerLazySingleton<SettingRepo>(() => SettingRepo());
  _registerBlocs();
}

Future<void> _registerBlocs() async {
  PaymentFeature.init();
  AttachmentFeature.init();
  PackageFeature.init();
  PayInsteadFeature.init();
  ContainerFeature.init();
  NotificationFeature.init();
  ContainerExpenseFeature.init();
  CustomerDoubleEntryFeature.init();
  SlideFeature.init();
}

//Exam schedule
Future<void> reInitRegisterBlocs() async {
  PaymentFeature.reInitBloc();
  AttachmentFeature.reInitBloc();
  PackageFeature.reInitBloc();
  PayInsteadFeature.reInitBloc();
  ContainerFeature.reInitBloc();
  NotificationFeature.reInitBloc();
  ContainerExpenseFeature.reInitBloc();
  CustomerDoubleEntryFeature.reInitBloc();
  SlideFeature.reInitBloc();
}
//
