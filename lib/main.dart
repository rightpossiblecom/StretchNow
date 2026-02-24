import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stretchnow/core/theme/app_theme.dart';
import 'package:stretchnow/core/constants/app_constants.dart';
import 'package:stretchnow/core/services/storage_service.dart';
import 'package:stretchnow/core/services/notification_service.dart';

import 'package:stretchnow/features/home/home_view_model.dart';
import 'package:stretchnow/features/schedule/schedule_view_model.dart';
import 'package:stretchnow/features/history/history_view_model.dart';
import 'package:stretchnow/features/settings/settings_view_model.dart';
import 'package:stretchnow/features/main/main_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Storage
  await Hive.initFlutter();
  await Hive.openBox<String>(AppConstants.appDataBox);
  await Hive.openBox<String>(AppConstants.settingsBox);

  final storageService = StorageService();

  // Notifications
  final notificationService = NotificationService();
  await notificationService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel(storageService)),
        ChangeNotifierProvider(
          create: (_) => ScheduleViewModel(storageService, notificationService),
        ),
        ChangeNotifierProvider(create: (_) => HistoryViewModel(storageService)),
        ChangeNotifierProvider(
          create: (_) => SettingsViewModel(storageService, notificationService),
        ),
      ],
      child: const StretchNowApp(),
    ),
  );
}

class StretchNowApp extends StatelessWidget {
  const StretchNowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(
      builder: (context, settingsViewModel, child) {
        return MaterialApp(
          title: 'StretchNow',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: settingsViewModel.themeMode,
          home: const MainScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
