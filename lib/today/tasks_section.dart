import 'package:flutter/material.dart';
import 'time_zone_section.dart';
import 'task.dart';

class TasksSection extends StatelessWidget {
  const TasksSection({
    super.key,
    required this.tasks,
    required this.onToggleTask,
  });
  final void Function(String) onToggleTask;
  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: 0.6,
          child: Text(
            'To Do · 2',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),

        TimeZoneSection(
          title: 'Morning',
          state: TimeZoneStates.past,
          emoji: '☀️',
          tasks: tasks,
          onToggleTask: onToggleTask,
        ),
        TimeZoneSection(
          title: 'Afternoon',
          state: TimeZoneStates.active,
          emoji: '🌤️',
          tasks: tasks,
          onToggleTask: onToggleTask,
        ),
        TimeZoneSection(
          title: 'Evening',
          state: TimeZoneStates.future,
          emoji: '🌙',
          tasks: tasks,
          onToggleTask: onToggleTask,
        ),
      ],
    );
  }
}
