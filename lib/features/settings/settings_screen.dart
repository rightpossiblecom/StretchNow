import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stretchnow/features/settings/settings_view_model.dart';
import 'package:stretchnow/features/about/about_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<SettingsViewModel>(
        builder: (context, viewModel, child) {
          return ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              Text(
                'Notifications',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text('Stretch Reminders'),
                      subtitle: const Text('Receive regular prompts to move'),
                      value: viewModel.notificationsEnabled,
                      activeThumbColor: theme.colorScheme.primary,
                      onChanged: viewModel.toggleNotifications,
                    ),
                    const Divider(height: 1),
                    SwitchListTile(
                      title: const Text('Vibration'),
                      subtitle: const Text('Vibrate when reminder arrives'),
                      value: viewModel.vibrationEnabled,
                      activeThumbColor: theme.colorScheme.primary,
                      onChanged: viewModel.notificationsEnabled
                          ? viewModel.toggleVibration
                          : null,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Appearance',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: RadioGroup<ThemeMode>(
                  groupValue: viewModel.themeMode,
                  onChanged: (val) => viewModel.setThemeMode(val!),
                  child: Column(
                    children: [
                      _ThemeRadioTile(
                        title: 'System Default',
                        value: ThemeMode.system,
                      ),
                      const Divider(height: 1),
                      _ThemeRadioTile(
                        title: 'Light',
                        value: ThemeMode.light,
                      ),
                      const Divider(height: 1),
                      _ThemeRadioTile(
                        title: 'Dark',
                        value: ThemeMode.dark,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Data & Support',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.info_outline),
                      title: const Text('About StretchNow'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const AboutScreen(),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.policy_outlined),
                      title: const Text('Privacy Policy'),
                      onTap: () => _showPolicyDialog(
                        context,
                        'Privacy Policy',
                        'We do not collect any personal data. All your routines and history remain securely stored on your local device.',
                      ),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.description_outlined),
                      title: const Text('Terms of Service'),
                      onTap: () => _showPolicyDialog(
                        context,
                        'Terms of Service',
                        'By using this utility app, you agree that it is designed only to encourage general movement, and is not a medical, fitness, or diagnostic tool.',
                      ),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: Icon(
                        Icons.delete_outline,
                        color: theme.colorScheme.error,
                      ),
                      title: Text(
                        'Reset Data',
                        style: TextStyle(color: theme.colorScheme.error),
                      ),
                      onTap: () => _confirmReset(context, viewModel),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              Center(
                child: Text(
                  'Version 1.0.0',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }

  void _showPolicyDialog(BuildContext context, String title, String content) {
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

  void _confirmReset(BuildContext context, SettingsViewModel viewModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
                const SnackBar(content: Text('App data reset successfully')),
              );
            },
            child: const Text('Reset', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _ThemeRadioTile extends StatelessWidget {
  final String title;
  final ThemeMode value;

  const _ThemeRadioTile({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<ThemeMode>(
      title: Text(title),
      value: value,
      fillColor: WidgetStateProperty.resolveWith((states) =>
          states.contains(WidgetState.selected)
              ? Theme.of(context).colorScheme.primary
              : null),
    );
  }
}
