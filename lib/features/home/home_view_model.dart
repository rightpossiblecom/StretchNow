import 'dart:math';
import 'package:flutter/material.dart';
import 'package:stretchnow/core/constants/app_constants.dart';
import 'package:stretchnow/core/services/storage_service.dart';

class HomeViewModel extends ChangeNotifier {
  final StorageService _storageService;

  HomeViewModel(this._storageService) {
    _initDailyData();
  }

  final int _dailyGoal = 4; // Default goal
  int get dailyGoal => _dailyGoal;

  int _dailyProgress = 0;
  int get dailyProgress => _dailyProgress;

  int _currentStreak = 0;
  int get currentStreak => _currentStreak;

  String _currentStretch = '';
  String get currentStretch => _currentStretch;

  bool _isQuickMode = false;
  bool get isQuickMode => _isQuickMode;

  final Random _random = Random();

  void _initDailyData() {
    final today = _getTodayDateStr();
    final lastStretchDate =
        _storageService.getString(AppConstants.keyLastStretchDate) ?? '';

    _currentStreak = _storageService.getInt(AppConstants.keyStreak);

    // Check if streak is broken (more than 1 day difference)
    if (lastStretchDate.isNotEmpty) {
      final lastDateObj = DateTime.parse(lastStretchDate);
      final todayObj = DateTime.parse(today);
      if (todayObj.difference(lastDateObj).inDays > 1) {
        _currentStreak = 0;
        _storageService.saveInt(AppConstants.keyStreak, 0);
      }
    }

    // Load today's progress
    _dailyProgress = _storageService.getInt(
      '${AppConstants.keyDailyProgress}$today',
    );

    _pickNextStretch();
  }

  String _getTodayDateStr() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  void _pickNextStretch() {
    final list = AppConstants.stretchSuggestions;
    _currentStretch = list[_random.nextInt(list.length)];
    notifyListeners();
  }

  Future<void> markStretchDone() async {
    final today = _getTodayDateStr();

    if (!_isQuickMode && _dailyProgress < _dailyGoal) {
      _dailyProgress++;
      await _storageService.saveInt(
        '${AppConstants.keyDailyProgress}$today',
        _dailyProgress,
      );
    }

    // Update streak if it's the first stretch of the day
    final lastStretchDate =
        _storageService.getString(AppConstants.keyLastStretchDate) ?? '';
    if (lastStretchDate != today) {
      _currentStreak++;
      await _storageService.saveInt(AppConstants.keyStreak, _currentStreak);

      final longestStreak = _storageService.getInt(
        AppConstants.keyLongestStreak,
      );
      if (_currentStreak > longestStreak) {
        await _storageService.saveInt(
          AppConstants.keyLongestStreak,
          _currentStreak,
        );
      }
    }

    await _storageService.saveString(AppConstants.keyLastStretchDate, today);

    // Reset quick mode after done
    _isQuickMode = false;
    _pickNextStretch();
  }

  void skipStretch() {
    _isQuickMode = false;
    _pickNextStretch();
  }

  void activateQuickMode() {
    _isQuickMode = true;
    _pickNextStretch();
  }
}
