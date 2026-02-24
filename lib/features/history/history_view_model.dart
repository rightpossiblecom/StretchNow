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

  final List<HistoryEntry> _historyEntries = [];
  List<HistoryEntry> get historyEntries => _historyEntries;

  void loadHistoryData() {
    _currentStreak = _storageService.getInt(AppConstants.keyStreak);
    _longestStreak = _storageService.getInt(AppConstants.keyLongestStreak);

    _historyEntries.clear();

    // Check last 30 days
    final now = DateTime.now();
    for (int i = 0; i < 30; i++) {
      final date = now.subtract(Duration(days: i));
      final dateStr =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

      final progress = _storageService.getInt(
        '${AppConstants.keyDailyProgress}$dateStr',
      );
      if (progress > 0 || i == 0) {
        // Always show today, or past days if progress > 0
        _historyEntries.add(
          HistoryEntry(
            date: dateStr,
            completed: progress,
            goal: 4, // Default goal based on requirements.
          ),
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
}
