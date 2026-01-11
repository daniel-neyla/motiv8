import 'package:flutter/material.dart';
import 'task_item.dart';
import '../../utils/day_phase.dart';
import '../../models/task.dart';

enum DayPhaseStates { past, active, future }

class DayPhaseSection extends StatefulWidget {
  // final void Function(String taskId) onToggle;
  const DayPhaseSection({
    super.key,
    required this.title,
    required this.dayPhase,
    required this.emoji,
    required this.tasks,
    required this.onToggleTask,
    required this.isEditingTasks,
    required this.onTaskDropped,
  });
  final String title;
  final DayPhase dayPhase;
  final String emoji;
  final List<Task> tasks;
  final bool isEditingTasks;
  final void Function(String) onToggleTask;
  final void Function(Task, DayPhase) onTaskDropped;

  @override
  State<DayPhaseSection> createState() => _DayPhaseSectionState();
}

class _DayPhaseSectionState extends State<DayPhaseSection> {
  bool isOpen = true;
  DayPhase currentPhase = getCurrentDayPhase(DateTime.now());
  DayPhaseStates get state {
    if (widget.dayPhase.index < currentPhase.index) {
      return DayPhaseStates.past;
    } else if (widget.dayPhase.index == currentPhase.index) {
      return DayPhaseStates.active;
    } else {
      return DayPhaseStates.future;
    }
  }

  @override
  initState() {
    super.initState();
    isOpen = state != DayPhaseStates.past;
  }

  @override
  Widget build(BuildContext context) {
    final isPast = state == DayPhaseStates.past;
    final isActive = state == DayPhaseStates.active;

    return _PhaseDropZone(
      phase: widget.dayPhase,
      state: state,
      onTaskDropped: widget.onTaskDropped,

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            _PhaseHeader(
              title: widget.title,
              emoji: widget.emoji,
              isOpen: isOpen,
              isPast: isPast,
              isActive: isActive,
              completedCount: widget.tasks.where((t) => t.completed).length,
              totalCount: widget.tasks.length,
              onTap: () {
                setState(() {
                  isOpen = !isOpen;
                });
              },
            ),
            if (isOpen) const SizedBox(height: 12),
            if (isOpen)
              _PhaseTaskList(
                tasks: widget.tasks,
                isEditing: widget.isEditingTasks,
                onToggleTask: widget.onToggleTask,
              ),
          ],
        ),
      ),
    );
  }
}

class _PhaseDropZone extends StatelessWidget {
  const _PhaseDropZone({
    required this.phase,
    required this.child,
    required this.onTaskDropped,
    required this.state,
  });

  final DayPhase phase;
  final Widget child;
  final DayPhaseStates state;
  final void Function(Task task, DayPhase targetPhase) onTaskDropped;

  @override
  Widget build(BuildContext context) {
    return DragTarget<Task>(
      // onWillAcceptWithDetails: (details) {
      //   return state != DayPhaseStates.past;
      // },
      onWillAcceptWithDetails: (_) => true,
      onAcceptWithDetails: (details) {
        onTaskDropped(details.data, phase);
      },
      builder: (context, _, _) => child,
    );
  }
}

class _PhaseHeader extends StatelessWidget {
  const _PhaseHeader({
    required this.title,
    required this.emoji,
    required this.isOpen,
    required this.isPast,
    required this.isActive,
    required this.completedCount,
    required this.totalCount,
    required this.onTap,
  });

  final String title;
  final String emoji;
  final bool isOpen;
  final bool isPast;
  final bool isActive;
  final int completedCount;
  final int totalCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkResponse(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isActive
              ? colorScheme.primaryContainer.withValues(alpha: 0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isActive
              ? Border.all(
                  color: colorScheme.primary.withAlpha(100),
                  width: 1.5,
                )
              : null,
        ),
        child: Opacity(
          opacity: isPast ? 0.4 : 1.0,
          child: Row(
            children: [
              Text(emoji),
              const SizedBox(width: 12),
              Text(
                '$title · $completedCount/$totalCount',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                ),
              ),
              const Spacer(),
              Icon(
                isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhaseTaskList extends StatelessWidget {
  const _PhaseTaskList({
    required this.tasks,
    required this.isEditing,
    required this.onToggleTask,
  });

  final List<Task> tasks;
  final bool isEditing;
  final void Function(String) onToggleTask;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(left: 24),
        child: Text(
          'No tasks',
          style: TextStyle(
            fontSize: 15,
            color: Theme.of(context).colorScheme.onSurface.withAlpha(120),
          ),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.only(left: isEditing ? 0 : 24),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      separatorBuilder: (_, _) => const SizedBox(height: 6),
      itemBuilder: (context, index) {
        final task = tasks[index];
        Widget taskWidget = TaskItem(
          task: task,
          isEditing: isEditing,
          onToggle: onToggleTask,
        );

        if (isEditing) {
          taskWidget = LongPressDraggable<Task>(
            data: task,
            feedback: Material(
              color: Colors.transparent,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TaskItem(task: task, isEditing: true, onToggle: (_) {}),
              ),
            ),
            childWhenDragging: Opacity(
              opacity: 0.4,
              child: TaskItem(task: task, isEditing: true, onToggle: (_) {}),
            ),
            child: TaskItem(
              task: task,
              isEditing: isEditing,
              onToggle: onToggleTask,
            ),
          );
        }

        return Row(
          children: [
            if (isEditing) ...[
              Icon(
                Icons.drag_indicator,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(120),
              ),
              const SizedBox(width: 8),
            ],
            Expanded(child: taskWidget),
          ],
        );
      },
    );
  }
}
