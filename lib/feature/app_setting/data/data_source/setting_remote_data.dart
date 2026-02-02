import 'dart:io';

import 'package:app/core/data_source/remote_data_source/remote_data_source_abs.dart';
import 'package:app/core/model/update_model.dart';
import 'package:app/core/shared/imports.dart';
import 'package:app/feature/app_setting/data/model/setting_model.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsRemoteSrcRepo {
  RemoteDataSourceAbs networkOperation = sl<RemoteDataSourceAbs>();
  Future<Either<Failure, UpdateModel?>> checkVersion() async {
    String platform = kIsWeb
        ? "web"
        : Platform.isAndroid
            ? "android"
            : "ios";
    String version = "";
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    logger("version $version");
    final res = await networkOperation.create(
        body: {"platform": platform, "version": version},
        isForm: true,
        errorMsg: Trans.failedToCheckVersion.trans(),
        showLoading: ShowLoading.none,
        successMsg: Trans.scuccefullyCheckVersion.trans(),
        endPoint: "check_version",
        showMessage: ShowMessage.none,
        fromJsonModel: UpdateModel.fromMap);
    return res;
  }

  Future<Either<Failure, SettingsModel?>> getAppSetting() async {
    final res = await networkOperation.getOne(
        errorMsg: Trans.failedToGetAppSettings.trans(),
        showLoading: ShowLoading.none,
        successMsg: Trans.scuccefullyGetAppSettings.trans(),
        endPoint: "settings",
        showMessage: ShowMessage.none,
        fromJsonModel: SettingsModel.fromMap);
    return res;
  }
}
