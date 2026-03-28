import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stretchnow/features/schedule/schedule_view_model.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Consumer<ScheduleViewModel>(
        builder: (context, viewModel, child) {
          return ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Schedule',
                        style: GoogleFonts.outfit(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Set when and how often you want reminders',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Reminder frequency
              Text(
                'Reminder Frequency',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurfaceVariant,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color:
                      colorScheme.surfaceContainerHighest.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: colorScheme.outlineVariant.withOpacity(0.4),
                  ),
                ),
                child: RadioGroup<int>(
                  groupValue: viewModel.intervalHours,
                  onChanged: (val) => viewModel.updateInterval(val!),
                  child: Column(
                    children: [
                      _IntervalTile(
                        title: 'Every hour',
                        subtitle: 'Most frequent',
                        value: 1,
                        icon: Icons.speed_outlined,
                      ),
                      Divider(
                          height: 1,
                          color: colorScheme.outlineVariant.withOpacity(0.3)),
                      _IntervalTile(
                        title: 'Every 2 hours',
                        subtitle: 'Recommended',
                        value: 2,
                        icon: Icons.timer_outlined,
                      ),
                      Divider(
                          height: 1,
                          color: colorScheme.outlineVariant.withOpacity(0.3)),
                      _IntervalTile(
                        title: 'Every 3 hours',
                        subtitle: 'Moderate',
                        value: 3,
                        icon: Icons.hourglass_bottom_outlined,
                      ),
                      Divider(
                          height: 1,
                          color: colorScheme.outlineVariant.withOpacity(0.3)),
                      _IntervalTile(
                        title: 'Every 4 hours',
                        subtitle: 'Minimal',
                        value: 4,
                        icon: Icons.snooze_outlined,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Active hours
              Text(
                'Active Hours',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurfaceVariant,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Reminders will only appear during these hours',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color:
                      colorScheme.surfaceContainerHighest.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: colorScheme.outlineVariant.withOpacity(0.4),
                  ),
                ),
                child: Column(
                  children: [
                    _TimeTile(
                      icon: Icons.wb_sunny_outlined,
                      iconColor: const Color(0xFFF59E0B),
                      label: 'Start Time',
                      value: viewModel.formatHour(viewModel.startHour),
                      onTap: () async {
                        final h = await _selectHour(
                            context, viewModel.startHour);
                        if (h != null) viewModel.updateStartHour(h);
                      },
                    ),
                    Divider(
                        height: 1,
                        indent: 56,
                        color:
                            colorScheme.outlineVariant.withOpacity(0.3)),
                    _TimeTile(
                      icon: Icons.nightlight_round_outlined,
                      iconColor: const Color(0xFF6366F1),
                      label: 'End Time',
                      value: viewModel.formatHour(viewModel.endHour),
                      onTap: () async {
                        final h = await _selectHour(
                            context, viewModel.endHour);
                        if (h != null) viewModel.updateEndHour(h);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 80),
            ],
          );
        },
      ),
    );
  }

  Future<int?> _selectHour(BuildContext context, int initialHour) async {
    final TimeOfDay? result = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: initialHour, minute: 0),
      initialEntryMode: TimePickerEntryMode.dialOnly,
      builder: (context, child) {
        return MediaQuery(
          data:
              MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    return result?.hour;
  }
}

class _IntervalTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final int value;
  final IconData icon;

  const _IntervalTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<int>(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle:
          Text(subtitle, style: const TextStyle(fontSize: 12)),
      secondary: Icon(icon, size: 20),
      value: value,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      fillColor: WidgetStateProperty.resolveWith((states) =>
          states.contains(WidgetState.selected)
              ? Theme.of(context).colorScheme.primary
              : null),
    );
  }
}

class _TimeTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _TimeTile({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 18),
      ),
      title: Text(label),
      trailing: Text(
        value,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.primary,
        ),
      ),
      onTap: onTap,
    );
  }
}
