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
          final progressPercent = (viewModel.dailyProgress / viewModel.dailyGoal).clamp(0.0, 1.0);

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.surface,
                  colorScheme.primary.withOpacity(0.05),
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
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
                              'StretchNow',
                              style: GoogleFonts.outfit(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                            ),
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
                    
                    const SizedBox(height: 32),

                    // Progress Overview
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.5)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Daily Goal',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${viewModel.dailyProgress} / ${viewModel.dailyGoal}',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: progressPercent,
                              minHeight: 10,
                              backgroundColor: colorScheme.surface,
                              valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // Stretch Card
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: _StretchCard(
                        key: ValueKey('${viewModel.currentStretch}_${viewModel.isQuickMode}'),
                        viewModel: viewModel,
                      ),
                    ),

                    const Spacer(),

                    // Action Area
                    if (!viewModel.isTimerRunning)
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: viewModel.skipStretch,
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 18),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  ),
                                  child: const Text('Skip'),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 2,
                                child: FilledButton(
                                  onPressed: viewModel.startTimer,
                                  style: FilledButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 18),
                                    backgroundColor: colorScheme.primary,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    elevation: 4,
                                    shadowColor: colorScheme.primary.withOpacity(0.4),
                                  ),
                                  child: const Text(
                                    'Start 60s Stretch',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          if (!viewModel.isQuickMode)
                            TextButton.icon(
                              onPressed: viewModel.activateQuickMode,
                              icon: const Icon(Icons.flash_on, size: 18),
                              label: const Text('Too busy? Try Quick Mode'),
                              style: TextButton.styleFrom(
                                foregroundColor: colorScheme.secondary,
                              ),
                            ),
                        ],
                      )
                    else
                      Column(
                        children: [
                          Text(
                            'Keep Stretching!',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: viewModel.markStretchDone,
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              ),
                              child: const Text('Stop Early'),
                            ),
                          ),
                        ],
                      ),
                    
                    const SizedBox(height: 24),
                  ],
                ),
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
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: streak > 0 ? Colors.orange.shade50 : colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: streak > 0 ? Colors.orange.shade200 : colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_fire_department_rounded,
            color: streak > 0 ? Colors.orange.shade600 : colorScheme.outline,
            size: 20,
          ),
          const SizedBox(width: 4),
          Text(
            '$streak',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: streak > 0 ? Colors.orange.shade900 : colorScheme.outline,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _StretchCard extends StatelessWidget {
  final HomeViewModel viewModel;

  const _StretchCard({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: viewModel.isQuickMode 
            ? colorScheme.secondaryContainer.withOpacity(0.9)
            : colorScheme.primaryContainer.withOpacity(0.9),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: (viewModel.isQuickMode ? colorScheme.secondary : colorScheme.primary)
                .withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          if (viewModel.isQuickMode)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: colorScheme.onSecondaryContainer.withOpacity(0.1),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.timer_outlined, size: 16, color: colorScheme.onSecondaryContainer),
                  const SizedBox(width: 6),
                  Text(
                    'QUICK MODE',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: colorScheme.onSecondaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          
          Text(
            'SUGGESTED STRETCH',
            style: theme.textTheme.labelLarge?.copyWith(
              color: viewModel.isQuickMode
                  ? colorScheme.onSecondaryContainer.withOpacity(0.6)
                  : colorScheme.onPrimaryContainer.withOpacity(0.6),
              letterSpacing: 2.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            viewModel.currentStretch,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: viewModel.isQuickMode
                  ? colorScheme.onSecondaryContainer
                  : colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 40),
          
          // Timer Widget
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  value: viewModel.secondsRemaining / 60,
                  strokeWidth: 8,
                  backgroundColor: (viewModel.isQuickMode 
                    ? colorScheme.onSecondaryContainer 
                    : colorScheme.onPrimaryContainer).withOpacity(0.12),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    viewModel.isQuickMode 
                      ? colorScheme.onSecondaryContainer 
                      : colorScheme.onPrimaryContainer
                  ),
                ),
              ),
              Text(
                '${viewModel.secondsRemaining}s',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: viewModel.isQuickMode
                      ? colorScheme.onSecondaryContainer
                      : colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
