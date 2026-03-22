import 'package:flutter/material.dart';
import 'package:stretchnow/core/constants/app_constants.dart';
import 'package:stretchnow/core/services/storage_service.dart';
import 'package:stretchnow/core/services/notification_service.dart';

class SettingsViewModel extends ChangeNotifier {
  final StorageService _storageService;
  final NotificationService _notificationService;

  SettingsViewModel(this._storageService, this._notificationService) {
    _loadSettings();
  }

  bool _notificationsEnabled = true;
  bool get notificationsEnabled => _notificationsEnabled;

  bool _vibrationEnabled = true;
  bool get vibrationEnabled => _vibrationEnabled;

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  int _dailyGoal = 4;
  int get dailyGoal => _dailyGoal;

  void _loadSettings() {
    _dailyGoal = _storageService.getSettingInt(
      AppConstants.keyDailyGoal,
      defaultValue: 4,
    );
    _notificationsEnabled = _storageService.getSettingBool(
      AppConstants.keyNotificationsEnabled,
      defaultValue: true,
    );
    _vibrationEnabled = _storageService.getSettingBool(
      AppConstants.keyVibrationEnabled,
      defaultValue: true,
    );

    final tmStr =
        _storageService.getSettingString(AppConstants.keyThemeMode) ?? 'system';
    if (tmStr == 'light') {
      _themeMode = ThemeMode.light;
    } else if (tmStr == 'dark') {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.system;
    }
  }

  Future<void> toggleNotifications(bool value) async {
    _notificationsEnabled = value;
    await _storageService.saveSettingBool(
      AppConstants.keyNotificationsEnabled,
      value,
    );

    if (value) {
      await _notificationService.requestPermissions();
      // Need to reschedule using schedule view model info
      final start = _storageService.getInt(
        AppConstants.keyActiveHoursStart,
        defaultValue: 9,
      );
      final end = _storageService.getInt(
        AppConstants.keyActiveHoursEnd,
        defaultValue: 17,
      );
      final interval = _storageService.getInt(
        AppConstants.keyReminderFrequency,
        defaultValue: 2,
      );

      await _notificationService.scheduleReminders(
        startHour: start,
        endHour: end,
        intervalHours: interval,
        vibrationsEnabled: _vibrationEnabled,
      );
    } else {
      await _notificationService.cancelAllReminders();
    }

    notifyListeners();
  }

  Future<void> toggleVibration(bool value) async {
    _vibrationEnabled = value;
    await _storageService.saveSettingBool(
      AppConstants.keyVibrationEnabled,
      value,
    );

    // Reschedule if notifications are enabled
    if (_notificationsEnabled) {
      final start = _storageService.getInt(
        AppConstants.keyActiveHoursStart,
        defaultValue: 9,
      );
      final end = _storageService.getInt(
        AppConstants.keyActiveHoursEnd,
        defaultValue: 17,
      );
      final interval = _storageService.getInt(
        AppConstants.keyReminderFrequency,
        defaultValue: 2,
      );

      await _notificationService.scheduleReminders(
        startHour: start,
        endHour: end,
        intervalHours: interval,
        vibrationsEnabled: _vibrationEnabled,
      );
    }

    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    final String modeStr = mode == ThemeMode.light
        ? 'light'
        : (mode == ThemeMode.dark ? 'dark' : 'system');
    await _storageService.saveSettingString(AppConstants.keyThemeMode, modeStr);
    notifyListeners();
  }

  Future<void> setDailyGoal(int goal) async {
    _dailyGoal = goal;
    await _storageService.saveSettingInt(AppConstants.keyDailyGoal, goal);
    notifyListeners();
  }

  Future<void> resetData() async {
    // Only clear app data, not settings
    await _storageService.saveInt(AppConstants.keyStreak, 0);
    await _storageService.saveInt(AppConstants.keyLongestStreak, 0);
    await _storageService.saveString(AppConstants.keyLastStretchDate, '');

    // Reset today's progress too
    final now = DateTime.now();
    final today =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    await _storageService.saveInt('${AppConstants.keyDailyProgress}$today', 0);

    notifyListeners();
  }
}
