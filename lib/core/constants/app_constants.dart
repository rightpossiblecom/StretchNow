class AppConstants {
  static const String appDataBox = 'app_data';
  static const String settingsBox = 'settings';

  static const String keyStreak = 'current_streak';
  static const String keyLongestStreak = 'longest_streak';
  static const String keyLastStretchDate = 'last_stretch_date';
  static const String keyDailyProgress =
      'daily_progress_'; // append date YYYY-MM-DD

  static const String keyActiveHoursStart = 'active_hours_start';
  static const String keyActiveHoursEnd = 'active_hours_end';
  static const String keyReminderFrequency = 'reminder_frequency_hours';
  static const String keyDailyGoal = 'daily_goal';

  static const String keyNotificationsEnabled = 'notifications_enabled';
  static const String keyVibrationEnabled = 'vibration_enabled';
  static const String keyThemeMode = 'theme_mode'; // 'system', 'light', 'dark'

  static const List<String> stretchSuggestions = [
    "Neck roll",
    "Shoulder roll",
    "Stand and reach",
    "Torso twist",
    "Wrist flex",
    "Ankle rotation",
    "Chest opener",
    "Upper back pull",
  ];
}
