import 'package:app/feature/app_setting/data/model/local_app_setting.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalAppSettingsRepo {
  final storage = const FlutterSecureStorage();

  LocalAppSettingsState appSettingsModel = LocalAppSettingsState.defaultConst();
  Future<void> initData() async {
    await getMode();
  }

  Future<void> setMode(LocalAppSettingsState newValue) async {
    await storage.write(key: _key, value: newValue.toJson());
    appSettingsModel = newValue;
  }

  Future<void> getMode() async {
    final val = await storage.read(key: _key);

    if (val != null) {
      appSettingsModel = LocalAppSettingsState.fromJson(val);
    }
  }

  final String _key = "APP_SETTINGS";

  Future<void> clearAll() async {
    await storage.delete(key: _key);
  }
}
