import 'package:flutter/material.dart';
import 'task_item.dart';

enum TimeZoneStates { past, active, future }

class TimeZoneSection extends StatefulWidget {
  final String title;
  final TimeZoneStates state;
  final String emoji;

  const TimeZoneSection({
    super.key,
    required this.title,
    required this.state,
    required this.emoji,
  });

  @override
  State<TimeZoneSection> createState() => _TimeZoneSectionState();
}

class _TimeZoneSectionState extends State<TimeZoneSection> {
  bool isOpen = true;
  @override
  initState() {
    super.initState();
    isOpen = widget.state != TimeZoneStates.past;
  }

  @override
  Widget build(BuildContext context) {
    final isPast = widget.state == TimeZoneStates.past;
    final isActive = widget.state == TimeZoneStates.active;

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
                      '${widget.title} · 1',
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
          if (isOpen)
            ListView(
              padding: const EdgeInsets.only(left: 24),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const SizedBox(height: 8),
                const TaskItem(title: 'Meditate', completed: true),
                const TaskItem(title: 'Review notes'),
                const TaskItem(title: 'Go for a walk'),
                const TaskItem(title: 'Plan tomorrow'),
              ],
            ),
        ],
      ),
    );
  }
}
