import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:stretchnow/core/constants/app_constants.dart';
import 'package:stretchnow/core/models/stretch_model.dart';
import 'package:stretchnow/core/services/storage_service.dart';

class HomeViewModel extends ChangeNotifier {
  final StorageService _storageService;

  HomeViewModel(this._storageService) {
    _initDailyData();
  }

  int _dailyGoal = 4;
  int get dailyGoal => _dailyGoal;

  int _dailyProgress = 0;
  int get dailyProgress => _dailyProgress;

  int _currentStreak = 0;
  int get currentStreak => _currentStreak;

  StretchExercise? _currentStretch;
  StretchExercise? get currentStretch => _currentStretch;

  bool _isQuickMode = false;
  bool get isQuickMode => _isQuickMode;

  Timer? _timer;
  int _secondsRemaining = 60;
  int get secondsRemaining => _secondsRemaining;

  int _totalDuration = 60;
  int get totalDuration => _totalDuration;

  bool _isTimerRunning = false;
  bool get isTimerRunning => _isTimerRunning;

  final Random _random = Random();

  String get greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  String get progressMessage {
    if (_dailyProgress == 0) return 'Ready to stretch?';
    if (_dailyProgress >= _dailyGoal) return 'Daily goal reached!';
    if (_dailyProgress >= _dailyGoal - 1) return 'Almost there!';
    return 'Keep it up!';
  }

  void _initDailyData() {
    final today = _getTodayDateStr();
    final lastStretchDate =
        _storageService.getString(AppConstants.keyLastStretchDate) ?? '';

    _currentStreak = _storageService.getInt(AppConstants.keyStreak);
    _dailyGoal = _storageService.getSettingInt(
      AppConstants.keyDailyGoal,
      defaultValue: 4,
    );

    if (lastStretchDate.isNotEmpty) {
      try {
        final lastDateObj = DateTime.parse(lastStretchDate);
        final todayObj = DateTime.parse(today);
        if (todayObj.difference(lastDateObj).inDays > 1) {
          _currentStreak = 0;
          _storageService.saveInt(AppConstants.keyStreak, 0);
        }
      } catch (e) {
        // Handle potential parse error
      }
    }

    _dailyProgress = _storageService.getInt(
      '${AppConstants.keyDailyProgress}$today',
    );

    _pickNextStretch();
  }

  String _getTodayDateStr() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  List<StretchExercise> _getFavorites() {
    final stored =
        _storageService.getString(AppConstants.keyFavoriteStretches) ?? '';
    if (stored.isEmpty) return [];
    final ids = stored.split(',');
    return StretchExercise.catalog
        .where((s) => ids.contains(s.id))
        .toList();
  }

  void _pickNextStretch() {
    _stopTimer();
    final favorites = _getFavorites();
    final pool =
        favorites.isNotEmpty ? favorites : StretchExercise.catalog;
    _currentStretch = pool[_random.nextInt(pool.length)];
    _totalDuration = _currentStretch!.durationSeconds;
    _secondsRemaining = _totalDuration;
    _isTimerRunning = false;
    notifyListeners();
  }

  void setStretch(StretchExercise stretch) {
    _stopTimer();
    _currentStretch = stretch;
    _totalDuration = stretch.durationSeconds;
    _secondsRemaining = _totalDuration;
    _isTimerRunning = false;
    notifyListeners();
  }

  void startTimer() {
    if (_isTimerRunning) return;

    _isTimerRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        notifyListeners();
      } else {
        _stopTimer();
        markStretchDone();
      }
    });
    notifyListeners();
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
    _isTimerRunning = false;
  }

  Future<void> markStretchDone() async {
    _stopTimer();
    final today = _getTodayDateStr();

    if (!_isQuickMode && _dailyProgress < _dailyGoal) {
      _dailyProgress++;
      await _storageService.saveInt(
        '${AppConstants.keyDailyProgress}$today',
        _dailyProgress,
      );
    }

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

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
