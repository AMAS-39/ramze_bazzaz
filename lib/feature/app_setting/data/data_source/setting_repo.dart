import 'package:app/core/shared/imports.dart';
import 'package:app/feature/app_setting/data/data_source/setting_local_data.dart';
import 'package:app/feature/app_setting/data/data_source/setting_remote_data.dart';
import 'package:app/feature/app_setting/data/model/setting_model.dart';

class SettingRepo {
  Future<Either<Failure, SettingsModel?>> getAppSetting(
      DataSource dataSource) async {
    if (dataSource.isLocal) {
      return Right(await sl<SettingsLocalSrcRepo>().getMode());
    }
    final res = await sl<SettingsRemoteSrcRepo>().getAppSetting();
    res.fold((l) {}, (r) {
      if (r != null) {
        sl<SettingsLocalSrcRepo>().setMode(r);
      }
    });
    return res;
  }
}
