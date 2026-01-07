import 'package:flutter/material.dart';
import 'task_item.dart';

enum DayPhaseStates { past, active, future }

class DayPhaseSection extends StatefulWidget {
  final String title;
  final DayPhaseStates state;
  final String emoji;
  final List tasks;
  // final void Function(String taskId) onToggle;
  const DayPhaseSection({
    super.key,
    required this.title,
    required this.state,
    required this.emoji,
    required this.tasks,
    required this.onToggleTask,
  });

  final void Function(String) onToggleTask;

  @override
  State<DayPhaseSection> createState() => _DayPhaseSectionState();
}

class _DayPhaseSectionState extends State<DayPhaseSection> {
  bool isOpen = true;

  @override
  initState() {
    super.initState();
    isOpen = widget.state != DayPhaseStates.past;
  }

  @override
  Widget build(BuildContext context) {
    final isPast = widget.state == DayPhaseStates.past;
    final isActive = widget.state == DayPhaseStates.active;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkResponse(
            onTap: () {
              setState(() {
                isOpen = !isOpen;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: isActive
                    ? Theme.of(
                        context,
                      ).colorScheme.primaryContainer.withValues(alpha: 0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: isActive
                    ? Border.all(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withAlpha(100),
                        width: 1.5,
                      )
                    : null,
              ),
              child: Opacity(
                opacity: isPast ? 0.4 : 1.0,
                child: Row(
                  children: [
                    Text(widget.emoji),
                    const SizedBox(width: 12),
                    Text(
                      '${widget.title} · 2/4',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isActive
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const Spacer(),

                    isOpen
                        ? const Icon(Icons.keyboard_arrow_up, size: 18)
                        : const Icon(Icons.keyboard_arrow_down, size: 18),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: isOpen ? 12 : 0),
          if (isOpen)
            if (widget.tasks.isNotEmpty)
              ListView.separated(
                padding: const EdgeInsets.only(left: 24),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return TaskItem(
                    task: widget.tasks[index],
                    onToggle: widget.onToggleTask,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 6);
                },
                itemCount: widget.tasks.length,
              )
            else
              Padding(
                padding: const EdgeInsets.only(left: 24),

                child: Text(
                  'No tasks',
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(120),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
