import 'package:flutter/material.dart';
import 'package:stretchnow/core/constants/app_constants.dart';
import 'package:stretchnow/core/services/notification_service.dart';
import 'package:stretchnow/core/services/storage_service.dart';

class ScheduleViewModel extends ChangeNotifier {
  final StorageService _storageService;
  final NotificationService _notificationService;

  ScheduleViewModel(this._storageService, this._notificationService) {
    _initScheduleData();
  }

  int _startHour = 9; // 9 AM
  int get startHour => _startHour;

  int _endHour = 17; // 5 PM
  int get endHour => _endHour;

  int _intervalHours = 2; // Every 2 hours
  int get intervalHours => _intervalHours;

  void _initScheduleData() {
    _startHour = _storageService.getInt(
      AppConstants.keyActiveHoursStart,
      defaultValue: 9,
    );
    _endHour = _storageService.getInt(
      AppConstants.keyActiveHoursEnd,
      defaultValue: 17,
    );
    _intervalHours = _storageService.getInt(
      AppConstants.keyReminderFrequency,
      defaultValue: 2,
    );
  }

  Future<void> updateStartHour(int hour) async {
    if (hour < _endHour) {
      _startHour = hour;
      await _storageService.saveInt(AppConstants.keyActiveHoursStart, hour);
      await _rescheduleNotifications();
      notifyListeners();
    }
  }

  Future<void> updateEndHour(int hour) async {
    if (hour > _startHour) {
      _endHour = hour;
      await _storageService.saveInt(AppConstants.keyActiveHoursEnd, hour);
      await _rescheduleNotifications();
      notifyListeners();
    }
  }

  Future<void> updateInterval(int hours) async {
    if (hours > 0) {
      _intervalHours = hours;
      await _storageService.saveInt(AppConstants.keyReminderFrequency, hours);
      await _rescheduleNotifications();
      notifyListeners();
    }
  }

  Future<void> _rescheduleNotifications() async {
    final enabled = _storageService.getSettingBool(
      AppConstants.keyNotificationsEnabled,
      defaultValue: true,
    );
    if (!enabled) return;

    final vibration = _storageService.getSettingBool(
      AppConstants.keyVibrationEnabled,
      defaultValue: true,
    );

    await _notificationService.scheduleReminders(
      startHour: _startHour,
      endHour: _endHour,
      intervalHours: _intervalHours,
      vibrationsEnabled: vibration,
    );
  }

  String formatHour(int hour) {
    if (hour == 0) return '12 AM';
    if (hour == 12) return '12 PM';
    return hour > 12 ? '${hour - 12} PM' : '$hour AM';
  }
}
