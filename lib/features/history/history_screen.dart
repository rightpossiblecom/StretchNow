import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stretchnow/features/history/history_view_model.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'History',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<HistoryViewModel>(
        builder: (context, viewModel, child) {
          return RefreshIndicator(
            onRefresh: () async {
              viewModel.loadHistoryData();
            },
            child: ListView(
              padding: const EdgeInsets.all(24.0),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _StreakCard(
                        title: 'Current Streak',
                        value: viewModel.currentStreak,
                        icon: Icons.local_fire_department,
                        color: Colors.orange.shade400,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _StreakCard(
                        title: 'Longest Streak',
                        value: viewModel.longestStreak,
                        icon: Icons.emoji_events,
                        color: Colors.amber.shade400,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                Text(
                  'Recent Days',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                if (viewModel.historyEntries.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text(
                        'No stretching history yet. Complete a stretch today to start your streak!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  )
                else
                  Card(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: viewModel.historyEntries.length,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final entry = viewModel.historyEntries[index];
                        final isComplete = entry.completed >= entry.goal;

                        return ListTile(
                          leading: Icon(
                            isComplete
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color: isComplete
                                ? theme.colorScheme.primary
                                : theme.colorScheme.outline,
                          ),
                          title: Text(viewModel.formatDisplayDate(entry.date)),
                          trailing: Text(
                            '${entry.completed}/${entry.goal}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: isComplete
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.onSurfaceVariant,
                              fontWeight: isComplete
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        );
                      },
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

class _StreakCard extends StatelessWidget {
  final String title;
  final int value;
  final IconData icon;
  final Color color;

  const _StreakCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              '$value',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            Text(
              title,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
