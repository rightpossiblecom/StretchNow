import 'package:flutter/material.dart';
import 'package:stretchnow/core/constants/app_constants.dart';
import 'package:stretchnow/core/services/storage_service.dart';
import 'package:intl/intl.dart';

class HistoryEntry {
  final String date;
  final int completed;
  final int goal;

  HistoryEntry({
    required this.date,
    required this.completed,
    required this.goal,
  });
}

class HistoryViewModel extends ChangeNotifier {
  final StorageService _storageService;

  HistoryViewModel(this._storageService) {
    loadHistoryData();
  }

  int _currentStreak = 0;
  int get currentStreak => _currentStreak;

  int _longestStreak = 0;
  int get longestStreak => _longestStreak;

  int _totalStretches = 0;
  int get totalStretches => _totalStretches;

  final List<HistoryEntry> _historyEntries = [];
  List<HistoryEntry> get historyEntries => _historyEntries;

  List<HistoryEntry> get lastSevenDays {
    final now = DateTime.now();
    final entries = <HistoryEntry>[];
    final goal = _storageService.getSettingInt(
      AppConstants.keyDailyGoal,
      defaultValue: 4,
    );

    for (int i = 6; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final dateStr =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      final progress = _storageService.getInt(
        '${AppConstants.keyDailyProgress}$dateStr',
      );
      entries.add(HistoryEntry(date: dateStr, completed: progress, goal: goal));
    }
    return entries;
  }

  void loadHistoryData() {
    final goal = _storageService.getSettingInt(
      AppConstants.keyDailyGoal,
      defaultValue: 4,
    );

    _currentStreak = _storageService.getInt(AppConstants.keyStreak);
    _longestStreak = _storageService.getInt(AppConstants.keyLongestStreak);

    _historyEntries.clear();
    _totalStretches = 0;

    final now = DateTime.now();
    for (int i = 0; i < 30; i++) {
      final date = now.subtract(Duration(days: i));
      final dateStr =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

      final progress = _storageService.getInt(
        '${AppConstants.keyDailyProgress}$dateStr',
      );
      _totalStretches += progress;

      if (progress > 0 || i == 0) {
        _historyEntries.add(
          HistoryEntry(date: dateStr, completed: progress, goal: goal),
        );
      }
    }

    notifyListeners();
  }

  String formatDisplayDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final now = DateTime.now();

      if (date.year == now.year &&
          date.month == now.month &&
          date.day == now.day) {
        return 'Today';
      }

      final yesterday = now.subtract(const Duration(days: 1));
      if (date.year == yesterday.year &&
          date.month == yesterday.month &&
          date.day == yesterday.day) {
        return 'Yesterday';
      }

      return DateFormat('MMM d, yyyy').format(date);
    } catch (_) {
      return dateStr;
    }
  }

  String formatShortDay(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('E').format(date).substring(0, 2);
    } catch (_) {
      return '?';
    }
  }
}
