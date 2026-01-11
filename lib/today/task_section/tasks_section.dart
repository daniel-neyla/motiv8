import 'package:flutter/material.dart';
import 'day_phase_section.dart';
import '../../models/task.dart';
import '../../utils/day_phase.dart';
import 'add_task_button.dart';

class TasksSection extends StatefulWidget {
  const TasksSection({
    super.key,
    required this.tasks,
    required this.onToggleTask,
    required this.onSubmit,
  });
  final void Function(String) onToggleTask;
  final void Function(String) onSubmit;
  final List<Task> tasks;

  @override
  State<TasksSection> createState() => _TasksSectionState();
}

class _TasksSectionState extends State<TasksSection> {
  bool isEditingTasks = false;
  void handleTaskDropped(Task task, DayPhase targetPhase) {
    setState(() {
      final index = widget.tasks.indexWhere((t) => t.id == task.id);
      if (index == -1) return;

      // Update only if phase changed
      if (widget.tasks[index].dayPhase != targetPhase) {
        widget.tasks[index] = widget.tasks[index].copyWith(
          dayPhase: targetPhase,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Opacity(
              opacity: 0.6,
              child: Text(
                widget.tasks.every((task) => task.completed)
                    ? 'All done for today! 🎉'
                    : 'To Do · (${widget.tasks.where((task) => !task.completed).length} left)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                foregroundColor: isEditingTasks
                    ? colorScheme.primary
                    : colorScheme.onSurface.withAlpha(200),
                backgroundColor: isEditingTasks
                    ? colorScheme.primary.withAlpha(20)
                    : colorScheme.onSurface.withAlpha(20),
              ),
              onPressed: () {
                setState(() {
                  isEditingTasks = !isEditingTasks;
                });
              },
              child: Text(
                isEditingTasks ? 'Done' : 'Edit',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        DayPhaseSection(
          title: 'Morning',
          dayPhase: DayPhase.morning,
          emoji: '☀️',
          tasks: widget.tasks
              .where((task) => task.dayPhase == DayPhase.morning)
              .toList(),
          onToggleTask: widget.onToggleTask,
          isEditingTasks: isEditingTasks,
          onTaskDropped: handleTaskDropped,
        ),
        DayPhaseSection(
          title: 'Afternoon',

          dayPhase: DayPhase.afternoon,
          emoji: '🌤️',
          tasks: widget.tasks
              .where((task) => task.dayPhase == DayPhase.afternoon)
              .toList(),
          onToggleTask: widget.onToggleTask,
          isEditingTasks: isEditingTasks,
          onTaskDropped: handleTaskDropped,
        ),
        DayPhaseSection(
          title: 'Evening',
          emoji: '🌙',
          dayPhase: DayPhase.evening,
          tasks: widget.tasks
              .where((task) => task.dayPhase == DayPhase.evening)
              .toList(),
          onToggleTask: widget.onToggleTask,
          isEditingTasks: isEditingTasks,
          onTaskDropped: handleTaskDropped,
        ),
        SizedBox(height: 16),
        AddTaskButton(onSubmit: widget.onSubmit),
        SizedBox(height: 16),
      ],
    );
  }
}
