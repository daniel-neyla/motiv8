import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final String title;
  final bool completed;
  final String id;
  final void Function(String taskId) onToggle;

  const TaskItem({
    super.key,
    required this.title,
    this.completed = false,

    required this.id,
    required this.onToggle,
  });

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
              onPressed: () => onToggle(id),

              icon: Icon(
                completed ? Icons.check_circle : Icons.radio_button_unchecked,
                size: 24,
                color: completed
                    ? colorScheme.primary
                    : colorScheme.onSurface.withAlpha(120),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  decoration: completed ? TextDecoration.lineThrough : null,
                  color: completed
                      ? colorScheme.onSurface.withAlpha(120)
                      : colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
