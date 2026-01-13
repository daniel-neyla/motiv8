import 'package:flutter/material.dart';
import '../../models/task.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.task,
    required this.onToggle,
    required this.isEditing,
    required this.onSetActive,
    required this.isActive,

    // required this.onToggle,
  });

  final void Function(String) onSetActive;
  final bool isActive;

  final Task task;
  final bool isEditing;
  final void Function(String) onToggle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(8),

        border: Border.all(color: colorScheme.onSurface.withAlpha(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),

        child: Row(
          children: [
            IconButton(
              onPressed: () {
                if (!isEditing) {
                  onToggle(task.id);
                }
              },

              icon: Icon(
                task.completed
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                size: 24,
                color: task.completed
                    ? colorScheme.primary
                    : colorScheme.onSurface.withAlpha(120),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                task.title,
                style: TextStyle(
                  fontSize: 15,
                  decoration: task.completed
                      ? TextDecoration.lineThrough
                      : null,
                  color: task.completed
                      ? colorScheme.onSurface.withAlpha(120)
                      : colorScheme.onSurface,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                isActive ? Icons.play_circle : Icons.play_circle_outline,
                color: isActive
                    ? colorScheme.primary
                    : colorScheme.onSurface.withAlpha(120),
              ),
              onPressed: () => onSetActive(task.id),
            ),
          ],
        ),
      ),
    );
  }
}
