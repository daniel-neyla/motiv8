import 'package:flutter/material.dart';
import 'day_phase_section.dart';
import '../../models/task.dart';
import '../../utils/day_phase.dart';

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
            tasks.every((task) => task.completed)
                ? 'All done for today! 🎉'
                : 'To Do · (${tasks.where((task) => !task.completed).length} left)',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),

        DayPhaseSection(
          title: 'Morning',
          dayPhase: DayPhase.morning,
          emoji: '☀️',
          tasks: tasks
              .where((task) => task.dayPhase == DayPhase.morning)
              .toList(),
          onToggleTask: onToggleTask,
        ),
        DayPhaseSection(
          title: 'Afternoon',

          dayPhase: DayPhase.afternoon,
          emoji: '🌤️',
          tasks: tasks
              .where((task) => task.dayPhase == DayPhase.afternoon)
              .toList(),
          onToggleTask: onToggleTask,
        ),
        DayPhaseSection(
          title: 'Evening',
          emoji: '🌙',
          dayPhase: DayPhase.evening,
          tasks: tasks
              .where((task) => task.dayPhase == DayPhase.evening)
              .toList(),
          onToggleTask: onToggleTask,
        ),
      ],
    );
  }
}
