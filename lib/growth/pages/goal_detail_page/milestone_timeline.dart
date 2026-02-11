import 'package:flutter/material.dart';
import '../../../models/milestone.dart';
import '../../../state/tasks_controller.dart';
import 'package:provider/provider.dart';

class MilestoneTimelineItem extends StatelessWidget {
  const MilestoneTimelineItem({
    super.key,
    required this.milestone,
    required this.index,
  });

  final Milestone milestone;
  final int index;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final tasksController = TasksController();
    final isCompleted = tasksController.isMilestoneCompleted(milestone.id);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LEFT TIMELINE
          SizedBox(
            width: 40,
            child: Column(
              children: [
                _MilestoneCircle(isCompleted: isCompleted, index: index),

                Expanded(
                  child: Container(width: 2, color: colorScheme.outlineVariant),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // RIGHT CONTENT
          Expanded(child: _MilestoneCard(milestone: milestone)),
        ],
      ),
    );
  }
}

class _MilestoneCircle extends StatelessWidget {
  const _MilestoneCircle({required this.isCompleted, required this.index});

  final bool isCompleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isCompleted ? colorScheme.primary : colorScheme.surface,
        shape: BoxShape.circle,
        border: Border.all(
          color: isCompleted ? colorScheme.primary : colorScheme.outline,
          width: 2,
        ),
      ),
      child: Center(
        child: isCompleted
            ? const Icon(Icons.check, size: 18, color: Colors.white)
            : Text(
                '${index + 1}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
      ),
    );
  }
}

class _MilestoneCard extends StatelessWidget {
  const _MilestoneCard({required this.milestone});

  final Milestone milestone;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final tasksController = TasksController();
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(milestone.title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...tasksController
              .tasksForMilestone(milestone.id)
              .map(
                (task) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          // if (!isEditing) {
                          //   onToggle(task.id);
                          // }
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
                      const SizedBox(width: 8),
                      Text(task.title, style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
          Divider(
            height: 32,
            thickness: 1,
            color: colorScheme.outlineVariant.withAlpha(100),
          ),
          GestureDetector(
            onTap: () {
              // Handle milestone card tap
            },
            child: Row(
              children: [
                Icon(Icons.add, size: 20),
                SizedBox(width: 12),
                Text('Add task'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddMilestoneTimelineItem extends StatelessWidget {
  const AddMilestoneTimelineItem({super.key, required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // LEFT: circle only (no connector below)
        SizedBox(
          width: 40,
          child: Column(
            children: [
              GestureDetector(
                onTap: onAdd,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    shape: BoxShape.circle,
                    border: Border.all(color: colorScheme.outline, width: 2),
                  ),
                  child: Icon(Icons.add, size: 16, color: Colors.black),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 12),

        // RIGHT: label
        Expanded(
          child: GestureDetector(
            onTap: onAdd,
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                'Add milestone',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.secondary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
