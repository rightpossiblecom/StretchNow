import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stretchnow/features/home/home_view_model.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'StretchNow',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          final todayStr = DateFormat('EEEE, MMM d').format(DateTime.now());

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Date & Progress
                Text(
                  todayStr,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Daily Progress: ${viewModel.dailyProgress} / ${viewModel.dailyGoal}',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),

                const Spacer(),

                // Stretch Card
                Card(
                  color: viewModel.isQuickMode
                      ? colorScheme.secondaryContainer
                      : colorScheme.primaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      children: [
                        if (viewModel.isQuickMode)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.flash_on,
                                  color: colorScheme.onSecondaryContainer,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '1-Minute Quick Stretch',
                                  style: TextStyle(
                                    color: colorScheme.onSecondaryContainer,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Text(
                          'Suggested Stretch',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: viewModel.isQuickMode
                                ? colorScheme.onSecondaryContainer
                                : colorScheme.onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          viewModel.currentStretch,
                          style: theme.textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: viewModel.isQuickMode
                                ? colorScheme.onSecondaryContainer
                                : colorScheme.onPrimaryContainer,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: viewModel.skipStretch,
                        icon: const Icon(Icons.skip_next),
                        label: const Text('Skip'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: FilledButton.icon(
                        onPressed: viewModel.markStretchDone,
                        icon: const Icon(Icons.check_circle),
                        label: const Text('Mark as Done'),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Quick Mode Button
                if (!viewModel.isQuickMode)
                  TextButton.icon(
                    onPressed: viewModel.activateQuickMode,
                    icon: const Icon(Icons.timer),
                    label: const Text('No time? Do a quick 60s stretch'),
                  ),

                const Spacer(),

                // Streak
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_fire_department,
                        color: Colors.orange.shade400,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Current Streak: ${viewModel.currentStreak} Days',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
