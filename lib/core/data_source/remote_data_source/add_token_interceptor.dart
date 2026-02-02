import 'dart:io';

import 'package:app/feature/account/presentation/bloc/account/account_bloc.dart';
import 'package:app/feature/app_setting/persentation/bloc/local_setting/local_app_setting_cubit.dart';
import 'package:app/injections.dart';
import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';

PackageInfo? _version;

class AddTokenInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (sl<AccountBloc>().info?.token != null) {
      options.headers.addAll({
        "Authorization": "Bearer ${sl<AccountBloc>().info?.token}",
      });
    }
    options.headers.addAll({
      HttpHeaders.acceptLanguageHeader: sl<LocalAppSettingsCubit>().state.lang,
      HttpHeaders.acceptHeader: "application/json"
    });
    _version ??= await PackageInfo.fromPlatform();
    final ver = "${_version?.version ?? ""}+${_version?.buildNumber ?? ""}";
    options.headers.addAll({"app-version": ver});
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      if (err.response!.statusCode == 401) {}
    }
    handler.next(err);
  }
}
