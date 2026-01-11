import 'package:flutter/material.dart';

class ReflectionStep extends StatefulWidget {
  const ReflectionStep({super.key});

  @override
  State<ReflectionStep> createState() => _ReflectionStepState();
}

class _ReflectionStepState extends State<ReflectionStep> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Anything you want to remember, learn, or let go of?',
          style: TextStyle(color: colorScheme.onSurface.withAlpha(150)),
        ),
        const SizedBox(height: 24),
        TextField(
          controller: _controller,
          maxLines: 6,
          decoration: InputDecoration(
            hintText: 'Write freely…',
            hintStyle: TextStyle(
              color: colorScheme.onSurface.withAlpha(
                100,
              ), // or your Motiv8 neutral
            ),
            filled: true,

            fillColor: colorScheme.surface,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: colorScheme.onSurface.withAlpha(100),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: colorScheme.primary, width: 2),
            ),
          ),
        ),
        SizedBox(height: 24),
        Center(
          child: Text(
            "This is just for you. No pressure.",
            style: TextStyle(color: colorScheme.onSurface.withAlpha(150)),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
