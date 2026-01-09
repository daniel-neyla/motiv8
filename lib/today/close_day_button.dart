import 'package:flutter/material.dart';

class CloseDayButton extends StatelessWidget {
  final double progress;

  const CloseDayButton({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => const SizedBox(),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            top: BorderSide(
              color: Theme.of(context).dividerColor.withAlpha(100),
              width: 1.5,
            ),
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24.0,
              backgroundColor: colorScheme.onSurface.withAlpha(20),
              child: Icon(
                Icons.night_shelter_outlined,
                color: colorScheme.onSurface.withAlpha(150),
                size: 28,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Close your day',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Icon(
              Icons.arrow_forward_ios,
              color: colorScheme.onSurface.withAlpha(100),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
