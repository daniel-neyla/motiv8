import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class AddTaskButton extends StatefulWidget {
  const AddTaskButton({super.key});

  @override
  State<AddTaskButton> createState() => _AddTaskButtonState();
}

class _AddTaskButtonState extends State<AddTaskButton> {
  bool isHovering = false;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bool isActive = isHovering || isPressed;
    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),

        child: Container(
          color: isActive
              ? Theme.of(context).colorScheme.primary.withAlpha(10)
              : Theme.of(context).colorScheme.onSurface.withAlpha(10),

          child: DottedBorder(
            color: isActive
                ? Theme.of(context).colorScheme.primary.withAlpha(50)
                : Theme.of(context).colorScheme.onSurface.withAlpha(50),

            strokeWidth: 4,
            dashPattern: [6, 4],
            borderType: BorderType.RRect,
            radius: const Radius.circular(12),
            child: InkWell(
              onTapDown: (_) => setState(() => isPressed = true),
              onTapUp: (_) => setState(() => isPressed = false),
              borderRadius: BorderRadius.circular(12),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,

                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.onSurface.withAlpha(20),
                      child: Icon(
                        Icons.add,
                        size: 18,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withAlpha(150),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Add something to today',
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withAlpha(150),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
