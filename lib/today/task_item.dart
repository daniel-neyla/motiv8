import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final String title;
  final bool completed;

  const TaskItem({super.key, required this.title, this.completed = false});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            completed ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 18,
            color: completed
                ? colorScheme.primary
                : colorScheme.onSurface.withAlpha(120),
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
    );
  }
}
