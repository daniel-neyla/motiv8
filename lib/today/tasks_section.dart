import 'package:flutter/material.dart';
import 'day_phase_section.dart';
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

        DayPhaseSection(
          title: 'Morning',
          state: DayPhaseStates.past,
          emoji: '☀️',
          tasks: tasks
              .where((task) => task.dayPhase == DayPhase.morning)
              .toList(),
          onToggleTask: onToggleTask,
        ),
        DayPhaseSection(
          title: 'Afternoon',
          state: DayPhaseStates.active,
          emoji: '🌤️',
          tasks: tasks
              .where((task) => task.dayPhase == DayPhase.afternoon)
              .toList(),
          onToggleTask: onToggleTask,
        ),
        DayPhaseSection(
          title: 'Evening',
          state: DayPhaseStates.future,
          emoji: '🌙',
          tasks: tasks
              .where((task) => task.dayPhase == DayPhase.evening)
              .toList(),
          onToggleTask: onToggleTask,
        ),
      ],
    );
  }
}
