import 'package:flutter/material.dart';
import 'close_day_overlay.dart';

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
          builder: (_) => const CloseDayOverlay(),
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
          mainAxisAlignment: MainAxisAlignment.center,
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
                    (progress < 1) ? 'Close your day' : 'Great work today!',
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
