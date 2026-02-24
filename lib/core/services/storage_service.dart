import 'package:hive_flutter/hive_flutter.dart';
import 'package:stretchnow/core/constants/app_constants.dart';

class StorageService {
  final Box<String> _appDataBox = Hive.box<String>(AppConstants.appDataBox);
  final Box<String> _settingsBox = Hive.box<String>(AppConstants.settingsBox);

  // General App Data
  Future<void> saveString(String key, String value) async =>
      _appDataBox.put(key, value);
  String? getString(String key) => _appDataBox.get(key);

  Future<void> saveInt(String key, int value) async =>
      _appDataBox.put(key, value.toString());
  int getInt(String key, {int defaultValue = 0}) {
    final val = _appDataBox.get(key);
    return val != null ? int.tryParse(val) ?? defaultValue : defaultValue;
  }

  // Settings
  Future<void> saveSettingBool(String key, bool value) async =>
      _settingsBox.put(key, value.toString());
  bool getSettingBool(String key, {bool defaultValue = false}) {
    final val = _settingsBox.get(key);
    return val != null ? val == 'true' : defaultValue;
  }

  Future<void> saveSettingString(String key, String value) async =>
      _settingsBox.put(key, value);
  String? getSettingString(String key) => _settingsBox.get(key);

  Future<void> saveSettingInt(String key, int value) async =>
      _settingsBox.put(key, value.toString());
  int getSettingInt(String key, {int defaultValue = 0}) {
    final val = _settingsBox.get(key);
    return val != null ? int.tryParse(val) ?? defaultValue : defaultValue;
  }

  Future<void> clearAll() async {
    await _appDataBox.clear();
    await _settingsBox.clear();
  }
}
