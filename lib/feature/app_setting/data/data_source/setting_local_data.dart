import 'package:app/feature/app_setting/data/model/setting_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SettingsLocalSrcRepo {
  final storage = const FlutterSecureStorage();

  SettingsModel appSettingsModel = const SettingsModel(
    success: true,
    message: "",
    data: SettingDataModel(
        accentColor: "",
        mainColor: "",
        mainDarkColor: "",
        scaffoldColor: "",
        scaffoldDarkColor: "",
        secondColor: "",
        secondDarkColor: "",
        defaultCurrency: "IQD",
        defaultTax: 0,
        accentDarkColor: "",
        appName: ""),
  );
  Future<void> initData() async {
    await getMode();
  }

  Future<void> setMode(SettingsModel newValue) async {
    await storage.write(key: key, value: newValue.toJson());
    appSettingsModel = newValue;
  }

  Future<SettingsModel> getMode() async {
    final val = await storage.read(key: key);

    if (val != null) {
      appSettingsModel = SettingsModel.fromJson(val);
    }
    return appSettingsModel;
  }

  String key = "SETTINGS";

  Future<void> clearAll() async {
    await storage.deleteAll();
  }
}
