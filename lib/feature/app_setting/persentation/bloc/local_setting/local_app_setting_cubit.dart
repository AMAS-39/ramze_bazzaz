import 'package:app/core/shared/imports.dart';
import 'package:app/feature/account/presentation/bloc/account/account_bloc.dart';
import 'package:app/feature/app_setting/data/data_source/app_setting_local_data.dart';
import 'package:app/feature/app_setting/data/model/local_app_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalAppSettingsCubit extends Cubit<LocalAppSettingsState> {
  final LocalAppSettingsRepo localAppSettings;
  LocalAppSettingsCubit({
    required this.localAppSettings,
  }) : super(localAppSettings.appSettingsModel);
  final prefs = sl<LocalAppSettingsRepo>();
  bool get isEn =>
      sl<LocalAppSettingsRepo>().appSettingsModel.lang == LanguageEnum.en;
  void toggleReciveNotifications(bool reciveNotificationsParam) {
    emit(state.copyWith(reciveNotification: reciveNotificationsParam));
    localAppSettings.setMode(state);
    if (state.reciveNotification != true) {}
  }

  void changeLang(LanguageEnum newLang) {
    if (newLang == state.lang) {
      return;
    }
    emit(state.copyWith(lang: newLang));
    if (sl<AccountBloc>().info != null) {
      // sl<AccountRemoteSrc>().updateUserLang(
      //     showLoading: ShowLoading.none,
      //     lang: newLang,
      //     loginModel: sl<LoginBloc>().info!);
    }
    localAppSettings.setMode(state);
  }

  void changeShowIntro(bool showIntro) {
    emit(state.copyWith(showIntro: showIntro));
    localAppSettings.setMode(state);
  }

  Future<void> changeTheme(ThemeMode theme) async {
    emit(state.copyWith(themeMode: theme));
    localAppSettings.setMode(state);
  }
}
