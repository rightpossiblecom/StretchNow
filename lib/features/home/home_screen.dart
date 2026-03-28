import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stretchnow/features/home/home_view_model.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          final todayStr = DateFormat('EEEE, MMM d').format(DateTime.now());
          final progressPercent =
              (viewModel.dailyProgress / viewModel.dailyGoal).clamp(0.0, 1.0);
          final stretch = viewModel.currentStretch;

          return SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            viewModel.greeting,
                            style: GoogleFonts.outfit(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            todayStr,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      _StreakBadge(streak: viewModel.currentStreak),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Progress card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest
                          .withOpacity(0.45),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: colorScheme.outlineVariant.withOpacity(0.4),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Daily Goal',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  viewModel.progressMessage,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                color: progressPercent >= 1.0
                                    ? const Color(0xFF22C55E).withOpacity(0.15)
                                    : colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(
                                '${viewModel.dailyProgress} / ${viewModel.dailyGoal}',
                                style: TextStyle(
                                  color: progressPercent >= 1.0
                                      ? const Color(0xFF22C55E)
                                      : colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: progressPercent,
                            minHeight: 8,
                            backgroundColor:
                                colorScheme.surfaceContainerHighest,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              progressPercent >= 1.0
                                  ? const Color(0xFF22C55E)
                                  : colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Stretch card
                  if (stretch != null)
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: _StretchCard(
                        key: ValueKey(
                            '${stretch.id}_${viewModel.isQuickMode}'),
                        viewModel: viewModel,
                        stretch: stretch,
                      ),
                    ),

                  const Spacer(),

                  // Action buttons
                  if (!viewModel.isTimerRunning)
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: viewModel.skipStretch,
                                style: OutlinedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  side: BorderSide(
                                    color: colorScheme.outlineVariant,
                                  ),
                                ),
                                child: Text(
                                  'Skip',
                                  style: TextStyle(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              flex: 2,
                              child: FilledButton(
                                onPressed: viewModel.startTimer,
                                style: FilledButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  backgroundColor: colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Text(
                                  'Start ${stretch?.durationSeconds ?? 60}s Stretch',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        if (!viewModel.isQuickMode)
                          TextButton.icon(
                            onPressed: viewModel.activateQuickMode,
                            icon: Icon(
                              Icons.bolt_outlined,
                              size: 18,
                              color: colorScheme.secondary,
                            ),
                            label: Text(
                              'Quick Mode',
                              style: TextStyle(color: colorScheme.secondary),
                            ),
                          ),
                      ],
                    )
                  else
                    Column(
                      children: [
                        Text(
                          'Keep stretching...',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: viewModel.markStretchDone,
                            style: OutlinedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              side: BorderSide(
                                color: colorScheme.outlineVariant,
                              ),
                            ),
                            child: const Text('Done Early'),
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _StreakBadge extends StatelessWidget {
  final int streak;
  const _StreakBadge({required this.streak});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isActive = streak > 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFFFFF7ED)
            : colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: isActive
              ? const Color(0xFFFED7AA)
              : colorScheme.outlineVariant,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_fire_department_rounded,
            color: isActive
                ? const Color(0xFFEA580C)
                : colorScheme.outline,
            size: 18,
          ),
          const SizedBox(width: 4),
          Text(
            '$streak',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isActive
                  ? const Color(0xFF9A3412)
                  : colorScheme.outline,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class _StretchCard extends StatelessWidget {
  final HomeViewModel viewModel;
  final dynamic stretch;

  const _StretchCard({
    super.key,
    required this.viewModel,
    required this.stretch,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final containerColor = viewModel.isQuickMode
        ? colorScheme.secondaryContainer
        : colorScheme.primaryContainer;
    final onContainerColor = viewModel.isQuickMode
        ? colorScheme.onSecondaryContainer
        : colorScheme.onPrimaryContainer;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          if (viewModel.isQuickMode)
            Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: onContainerColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.bolt_outlined,
                      size: 14, color: onContainerColor),
                  const SizedBox(width: 4),
                  Text(
                    'QUICK MODE',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: onContainerColor,
                    ),
                  ),
                ],
              ),
            ),

          // Body part badge
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: onContainerColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(stretch.bodyPart.icon,
                    size: 14, color: onContainerColor.withOpacity(0.7)),
                const SizedBox(width: 6),
                Text(
                  stretch.bodyPart.label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: onContainerColor.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Text(
            stretch.name,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: onContainerColor,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            stretch.description,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: onContainerColor.withOpacity(0.6),
              height: 1.4,
            ),
          ),

          const SizedBox(height: 28),

          // Timer ring
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 90,
                height: 90,
                child: CircularProgressIndicator(
                  value: viewModel.secondsRemaining / viewModel.totalDuration,
                  strokeWidth: 6,
                  strokeCap: StrokeCap.round,
                  backgroundColor: onContainerColor.withOpacity(0.1),
                  valueColor:
                      AlwaysStoppedAnimation<Color>(onContainerColor),
                ),
              ),
              Text(
                '${viewModel.secondsRemaining}s',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: onContainerColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
