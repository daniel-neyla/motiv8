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
  String? activeTaskId;

  void toggleTask(String taskId) {
    setState(() {
      debugPrint('Setting active task: $taskId');
      Task t = widget.tasks.firstWhere((task) => task.id == taskId);
      debugPrint('Active task title: ${t.title}');
      if (activeTaskId != taskId) {
        activeTaskId = taskId;
      } else {
        activeTaskId = null;
      }
    });
  }

  void clearActiveTask() {
    setState(() {
      activeTaskId = null;
    });
  }

  void handleTaskDropped(
    Task draggedTask,
    DayPhase targetPhase,
    Task? targetTask,
  ) {
    setState(() {
      final updatedTasks = List<Task>.from(widget.tasks);

      // Case 0: No-op guard (very important)
      if (draggedTask.dayPhase == targetPhase && targetTask == null) {
        return;
      }

      // Remove dragged task
      final draggedIndex = updatedTasks.indexWhere(
        (t) => t.id == draggedTask.id,
      );
      final removedTask = updatedTasks.removeAt(draggedIndex);

      // CASE 1: moved to another phase → append
      if (removedTask.dayPhase != targetPhase) {
        final maxOrder = updatedTasks
            .where((t) => t.dayPhase == targetPhase)
            .fold<int>(0, (max, t) => t.order > max ? t.order : max);

        updatedTasks.add(
          removedTask.copyWith(dayPhase: targetPhase, order: maxOrder + 1),
        );
      }
      // CASE 2: reorder inside same phase
      else if (targetTask != null) {
        final targetIndex = updatedTasks.indexWhere(
          (t) => t.id == targetTask.id,
        );
        final safeIndex = targetIndex.clamp(0, updatedTasks.length);

        updatedTasks.insert(
          safeIndex,
          removedTask.copyWith(order: targetTask.order),
        );

        // Normalize order inside phase
        final phaseTasks =
            updatedTasks.where((t) => t.dayPhase == targetPhase).toList()
              ..sort((a, b) => a.order.compareTo(b.order));

        for (int i = 0; i < phaseTasks.length; i++) {
          final index = updatedTasks.indexWhere(
            (t) => t.id == phaseTasks[i].id,
          );
          updatedTasks[index] = phaseTasks[i].copyWith(order: i);
        }
      }

      widget.tasks
        ..clear()
        ..addAll(updatedTasks);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (activeTaskId != null)
          _ActiveTaskBanner(
            task: widget.tasks.firstWhere((t) => t.id == activeTaskId),
            onClear: clearActiveTask,
          ),
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
          onToggleActive: toggleTask,
          activeTaskId: activeTaskId,
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
          onToggleActive: toggleTask,
          activeTaskId: activeTaskId,
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
          onToggleActive: toggleTask,
          activeTaskId: activeTaskId,
        ),
        SizedBox(height: 16),
        AddTaskButton(onSubmit: widget.onSubmit),
        SizedBox(height: 16),
      ],
    );
  }
}

class _ActiveTaskBanner extends StatelessWidget {
  final Task task;
  final VoidCallback onClear;

  const _ActiveTaskBanner({required this.task, required this.onClear});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.primary.withAlpha(20),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.primary, width: 1.0),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: colorScheme.primary.withAlpha(20),
            child: Icon(Icons.play_arrow, color: colorScheme.primary),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Active Now".toUpperCase(),
                  style: TextStyle(color: colorScheme.primary),
                ),

                Text(
                  task.title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          IconButton(icon: const Icon(Icons.close), onPressed: onClear),
        ],
      ),
    );
  }
}
