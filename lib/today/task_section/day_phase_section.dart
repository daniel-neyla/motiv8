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
  final void Function(Task, DayPhase, Task?) onTaskDropped;

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
    final phaseTasks = [...widget.tasks]
      ..sort((a, b) => a.order.compareTo(b.order));
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
                tasks: phaseTasks,
                isEditing: widget.isEditingTasks,
                onToggleTask: widget.onToggleTask,
                phase: widget.dayPhase,
                onTaskDropped: widget.onTaskDropped,
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
  final void Function(Task task, DayPhase targetPhase, Task? targetTask)
  onTaskDropped;

  @override
  Widget build(BuildContext context) {
    return DragTarget<Task>(
      // onWillAcceptWithDetails: (details) {
      //   return state != DayPhaseStates.past;
      // },
      onWillAcceptWithDetails: (details) {
        return details.data.dayPhase != phase;
      },
      onAcceptWithDetails: (details) {
        onTaskDropped(details.data, phase, null);
      },
      builder: (context, candidateData, _) {
        final isActive = candidateData.isNotEmpty;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: isActive
                ? Theme.of(context).primaryColor.withAlpha(15)
                : Colors.transparent,
            border: Border.all(
              color: isActive
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
              width: isActive ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              child,
              if (isActive) const Icon(Icons.arrow_downward, size: 16),
            ],
          ),
        );
      },
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
    required this.phase,
    required this.onTaskDropped,
  });

  final List<Task> tasks;
  final bool isEditing;
  final void Function(String) onToggleTask;
  final DayPhase phase;
  final void Function(Task, DayPhase, Task?) onTaskDropped;

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
          taskWidget = DragTarget<Task>(
            onWillAcceptWithDetails: (details) {
              return details.data.dayPhase == phase;
            },
            onAcceptWithDetails: (details) {
              onTaskDropped(details.data, phase, task);
            },
            builder: (context, candidateData, rejectedData) {
              final isHovering = candidateData.isNotEmpty;
              return Column(
                children: [
                  if (isHovering)
                    Container(
                      height: 4,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  LongPressDraggable<Task>(
                    data: task,
                    feedback: Material(
                      color: Colors.transparent,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TaskItem(
                          task: task,
                          isEditing: true,
                          onToggle: (_) {},
                        ),
                      ),
                    ),
                    childWhenDragging: Opacity(
                      opacity: 0.4,
                      child: TaskItem(
                        task: task,
                        isEditing: true,
                        onToggle: (_) {},
                      ),
                    ),
                    child: TaskItem(
                      task: task,
                      isEditing: isEditing,
                      onToggle: onToggleTask,
                    ),
                  ),
                ],
              );
            },
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
