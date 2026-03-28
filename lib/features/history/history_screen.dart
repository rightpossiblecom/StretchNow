import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stretchnow/features/history/history_view_model.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Consumer<HistoryViewModel>(
        builder: (context, viewModel, child) {
          final weekDays = viewModel.lastSevenDays;

          return RefreshIndicator(
            onRefresh: () async => viewModel.loadHistoryData(),
            child: ListView(
              padding: const EdgeInsets.all(24.0),
              children: [
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    child: Text(
                      'History',
                      style: GoogleFonts.outfit(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Stats row
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        label: 'Current\nStreak',
                        value: '${viewModel.currentStreak}',
                        icon: Icons.local_fire_department_rounded,
                        iconColor: const Color(0xFFEA580C),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _StatCard(
                        label: 'Longest\nStreak',
                        value: '${viewModel.longestStreak}',
                        icon: Icons.emoji_events_rounded,
                        iconColor: const Color(0xFFF59E0B),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _StatCard(
                        label: 'Total\nStretches',
                        value: '${viewModel.totalStretches}',
                        icon: Icons.fitness_center_rounded,
                        iconColor: const Color(0xFF8B5CF6),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // Week at a glance
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color:
                        colorScheme.surfaceContainerHighest.withOpacity(0.45),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: colorScheme.outlineVariant.withOpacity(0.4),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'This Week',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: weekDays.map((entry) {
                          final progress = entry.goal > 0
                              ? (entry.completed / entry.goal).clamp(0.0, 1.0)
                              : 0.0;
                          final isToday =
                              viewModel.formatDisplayDate(entry.date) ==
                                  'Today';
                          return _WeekDayDot(
                            dayLabel:
                                viewModel.formatShortDay(entry.date),
                            progress: progress,
                            isToday: isToday,
                            count: entry.completed,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                Text(
                  'Recent Activity',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),

                if (viewModel.historyEntries.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.self_improvement_outlined,
                            size: 48,
                            color: colorScheme.outlineVariant,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No stretching history yet.\nComplete a stretch to get started!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ...viewModel.historyEntries.map((entry) {
                    final isComplete = entry.completed >= entry.goal;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest
                            .withOpacity(0.35),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color:
                              colorScheme.outlineVariant.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: isComplete
                                  ? const Color(0xFF22C55E).withOpacity(0.15)
                                  : colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              isComplete
                                  ? Icons.check_rounded
                                  : Icons.radio_button_unchecked,
                              color: isComplete
                                  ? const Color(0xFF22C55E)
                                  : colorScheme.outline,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              viewModel.formatDisplayDate(entry.date),
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: isComplete
                                  ? const Color(0xFF22C55E).withOpacity(0.12)
                                  : colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${entry.completed}/${entry.goal}',
                              style: TextStyle(
                                color: isComplete
                                    ? const Color(0xFF22C55E)
                                    : colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                const SizedBox(height: 80),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.45),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outlineVariant.withOpacity(0.4),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _WeekDayDot extends StatelessWidget {
  final String dayLabel;
  final double progress;
  final bool isToday;
  final int count;

  const _WeekDayDot({
    required this.dayLabel,
    required this.progress,
    required this.isToday,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final Color dotColor;
    if (progress >= 1.0) {
      dotColor = const Color(0xFF22C55E);
    } else if (progress > 0) {
      dotColor = colorScheme.primary;
    } else {
      dotColor = colorScheme.outlineVariant;
    }

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 34,
              height: 34,
              child: CircularProgressIndicator(
                value: progress > 0 ? progress : 0.0,
                strokeWidth: 3,
                strokeCap: StrokeCap.round,
                backgroundColor: colorScheme.outlineVariant.withOpacity(0.3),
                valueColor: AlwaysStoppedAnimation<Color>(dotColor),
              ),
            ),
            if (progress >= 1.0)
              Icon(Icons.check_rounded, size: 14, color: dotColor)
            else
              Text(
                '$count',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: progress > 0
                      ? colorScheme.onSurface
                      : colorScheme.outlineVariant,
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          dayLabel,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isToday ? FontWeight.bold : FontWeight.w500,
            color: isToday ? colorScheme.primary : colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
