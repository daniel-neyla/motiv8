import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class AddTaskButton extends StatefulWidget {
  const AddTaskButton({super.key, required this.onSubmit});

  final void Function(String title) onSubmit;

  @override
  State<AddTaskButton> createState() => _AddTaskButtonState();
}

class _AddTaskButtonState extends State<AddTaskButton> {
  bool isHovering = false;
  bool isPressed = false;
  bool isEditing = false;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _startEditing() {
    setState(() => isEditing = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    widget.onSubmit(text);
    _controller.clear();
    setState(() => isEditing = false);
  }

  void _cancel() {
    _controller.clear();
    setState(() => isEditing = false);
  }

  @override
  Widget build(BuildContext context) {
    return isEditing ? _buildInput() : _buildButton();
  }

  Widget _buildButton() {
    final bool isActive = isHovering || isPressed;
    return GestureDetector(
      onTap: _startEditing,
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovering = true),
        onExit: (_) => setState(() => isHovering = false),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),

          child: Container(
            color: isActive
                ? Theme.of(context).colorScheme.primary.withAlpha(10)
                : Colors.transparent,

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
                onTap: () {
                  _startEditing();
                },
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
      ),
    );
  }

  Widget _buildInput() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _cancel,

      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  decoration: const InputDecoration(
                    hintText: 'Add a task...',
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  onSubmitted: (_) => _submit(),
                ),
              ),

              // Dismiss button
              IconButton(
                icon: Icon(
                  Icons.close,
                  size: 20,
                  color: Theme.of(context).colorScheme.outline,
                ),
                onPressed: () {
                  _controller.clear();
                  _focusNode.unfocus();
                  // onDismiss?.call(); // optional
                },
              ),

              // Confirm button
              IconButton(
                icon: Icon(
                  Icons.check,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && isEditing) {
        _cancel();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
