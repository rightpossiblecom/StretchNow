import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stretchnow/features/settings/settings_view_model.dart';
import 'package:stretchnow/features/about/about_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Consumer<SettingsViewModel>(
        builder: (context, viewModel, child) {
          return ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 4),
                  child: Text(
                    'Settings',
                    style: GoogleFonts.outfit(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Goals
              _SectionLabel(label: 'GOALS'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: _cardDecoration(colorScheme),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Daily Stretch Goal',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            '${viewModel.dailyGoal}',
                            style: TextStyle(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SliderTheme(
                      data: SliderThemeData(
                        trackHeight: 4,
                        thumbShape:
                            const RoundSliderThumbShape(enabledThumbRadius: 8),
                        overlayShape:
                            const RoundSliderOverlayShape(overlayRadius: 16),
                        activeTrackColor: colorScheme.primary,
                        inactiveTrackColor:
                            colorScheme.outlineVariant.withOpacity(0.3),
                        thumbColor: colorScheme.primary,
                      ),
                      child: Slider(
                        value: viewModel.dailyGoal.toDouble(),
                        min: 1,
                        max: 12,
                        divisions: 11,
                        onChanged: (val) =>
                            viewModel.setDailyGoal(val.toInt()),
                      ),
                    ),
                    Text(
                      '4-6 stretches daily is recommended for consistency.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Notifications
              _SectionLabel(label: 'NOTIFICATIONS'),
              const SizedBox(height: 12),
              Container(
                decoration: _cardDecoration(colorScheme),
                child: Column(
                  children: [
                    _SwitchTile(
                      icon: Icons.notifications_outlined,
                      iconColor: colorScheme.primary,
                      title: 'Stretch Reminders',
                      subtitle: 'Regular prompts to move',
                      value: viewModel.notificationsEnabled,
                      onChanged: viewModel.toggleNotifications,
                    ),
                    Divider(
                        height: 1,
                        indent: 56,
                        color:
                            colorScheme.outlineVariant.withOpacity(0.3)),
                    _SwitchTile(
                      icon: Icons.vibration_outlined,
                      iconColor: colorScheme.secondary,
                      title: 'Vibration',
                      subtitle: 'Vibrate on reminder',
                      value: viewModel.vibrationEnabled,
                      onChanged: viewModel.notificationsEnabled
                          ? viewModel.toggleVibration
                          : null,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Appearance
              _SectionLabel(label: 'APPEARANCE'),
              const SizedBox(height: 12),
              Container(
                decoration: _cardDecoration(colorScheme),
                child: Column(
                  children: [
                    _ThemeTile(
                      title: 'System Default',
                      icon: Icons.brightness_auto_outlined,
                      isSelected: viewModel.themeMode == ThemeMode.system,
                      onTap: () =>
                          viewModel.setThemeMode(ThemeMode.system),
                    ),
                    Divider(
                        height: 1,
                        indent: 56,
                        color:
                            colorScheme.outlineVariant.withOpacity(0.3)),
                    _ThemeTile(
                      title: 'Light',
                      icon: Icons.light_mode_outlined,
                      isSelected: viewModel.themeMode == ThemeMode.light,
                      onTap: () =>
                          viewModel.setThemeMode(ThemeMode.light),
                    ),
                    Divider(
                        height: 1,
                        indent: 56,
                        color:
                            colorScheme.outlineVariant.withOpacity(0.3)),
                    _ThemeTile(
                      title: 'Dark',
                      icon: Icons.dark_mode_outlined,
                      isSelected: viewModel.themeMode == ThemeMode.dark,
                      onTap: () =>
                          viewModel.setThemeMode(ThemeMode.dark),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Data & Support
              _SectionLabel(label: 'DATA & SUPPORT'),
              const SizedBox(height: 12),
              Container(
                decoration: _cardDecoration(colorScheme),
                child: Column(
                  children: [
                    _ActionTile(
                      icon: Icons.info_outline_rounded,
                      iconColor: colorScheme.primary,
                      title: 'About StretchNow',
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const AboutScreen(),
                        ),
                      ),
                    ),
                    Divider(
                        height: 1,
                        indent: 56,
                        color:
                            colorScheme.outlineVariant.withOpacity(0.3)),
                    _ActionTile(
                      icon: Icons.shield_outlined,
                      iconColor: const Color(0xFF22C55E),
                      title: 'Privacy Policy',
                      onTap: () => _showPolicyDialog(
                        context,
                        'Privacy Policy',
                        'We do not collect any personal data. All your routines and history remain securely stored on your local device.',
                      ),
                    ),
                    Divider(
                        height: 1,
                        indent: 56,
                        color:
                            colorScheme.outlineVariant.withOpacity(0.3)),
                    _ActionTile(
                      icon: Icons.delete_outline_rounded,
                      iconColor: colorScheme.error,
                      title: 'Reset Data',
                      titleColor: colorScheme.error,
                      onTap: () => _confirmReset(context, viewModel),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              Center(
                child: Column(
                  children: [
                    Text(
                      'StretchNow',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Version 1.0.1',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
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

  BoxDecoration _cardDecoration(ColorScheme colorScheme) {
    return BoxDecoration(
      color: colorScheme.surfaceContainerHighest.withOpacity(0.45),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: colorScheme.outlineVariant.withOpacity(0.4),
      ),
    );
  }

  void _showPolicyDialog(
      BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _confirmReset(
      BuildContext context, SettingsViewModel viewModel) {
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Reset Data?'),
        content: const Text(
          'This will clear your streak and history. Settings will remain unchanged.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              viewModel.resetData();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('App data reset successfully'),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
            child: Text(
              'Reset',
              style: TextStyle(color: colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            letterSpacing: 0.8,
          ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;

  const _SwitchTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      secondary: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 18),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle:
          Text(subtitle, style: const TextStyle(fontSize: 12)),
      value: value,
      onChanged: onChanged,
    );
  }
}

class _ThemeTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeTile({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: (isSelected ? colorScheme.primary : colorScheme.outline)
              .withOpacity(0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: isSelected ? colorScheme.primary : colorScheme.outline,
          size: 18,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          color: isSelected ? colorScheme.primary : null,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle_rounded,
              color: colorScheme.primary, size: 22)
          : null,
      onTap: onTap,
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Color? titleColor;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.titleColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: titleColor,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: Theme.of(context).colorScheme.outline,
      ),
      onTap: onTap,
    );
  }
}
