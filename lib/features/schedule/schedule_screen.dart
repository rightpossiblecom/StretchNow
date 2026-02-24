import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stretchnow/features/schedule/schedule_view_model.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'Schedule',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<ScheduleViewModel>(
        builder: (context, viewModel, child) {
          return ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              Text(
                'Reminder Frequency',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RadioGroup<int>(
                    groupValue: viewModel.intervalHours,
                    onChanged: (val) => viewModel.updateInterval(val!),
                    child: Column(
                      children: [
                        _buildIntervalTile(
                          context: context,
                          title: 'Every 1 Hour',
                          value: 1,
                        ),
                        const Divider(),
                        _buildIntervalTile(
                          context: context,
                          title: 'Every 2 Hours',
                          value: 2,
                        ),
                        const Divider(),
                        _buildIntervalTile(
                          context: context,
                          title: 'Every 3 Hours',
                          value: 3,
                        ),
                        const Divider(),
                        _buildIntervalTile(
                          context: context,
                          title: 'Every 4 Hours',
                          value: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              Text(
                'Active Hours',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.wb_sunny_outlined),
                        title: const Text('Start Time'),
                        trailing: Text(
                          viewModel.formatHour(viewModel.startHour),
                          style: theme.textTheme.titleMedium,
                        ),
                        onTap: () async {
                          final h = await _selectHour(
                            context,
                            viewModel.startHour,
                          );
                          if (h != null) viewModel.updateStartHour(h);
                        },
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.nightlight_round),
                        title: const Text('End Time'),
                        trailing: Text(
                          viewModel.formatHour(viewModel.endHour),
                          style: theme.textTheme.titleMedium,
                        ),
                        onTap: () async {
                          final h = await _selectHour(
                            context,
                            viewModel.endHour,
                          );
                          if (h != null) viewModel.updateEndHour(h);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildIntervalTile({
    required BuildContext context,
    required String title,
    required int value,
  }) {
    return RadioListTile<int>(
      title: Text(title),
      value: value,
      contentPadding: EdgeInsets.zero,
      fillColor: WidgetStateProperty.resolveWith((states) =>
          states.contains(WidgetState.selected)
              ? Theme.of(context).colorScheme.primary
              : null),
    );
  }

  Future<int?> _selectHour(BuildContext context, int initialHour) async {
    final TimeOfDay? result = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: initialHour, minute: 0),
      initialEntryMode: TimePickerEntryMode.dialOnly,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    return result?.hour;
  }
}
