import 'package:flutter/material.dart';
import 'close_day/close_day_overlay.dart';
import 'package:motiv8/models/day_review.dart';

class CloseDayButton extends StatelessWidget {
  final DayReview review;

  const CloseDayButton({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final double progress = review.completedTasks / review.numOfTasks;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => CloseDayOverlay(review: review),
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
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (progress < 1) ? 'Ready to wrap up?' : 'Great work today',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                  ),

                  Text(
                    (progress < 1)
                        ? "${review.numOfTasks - review.completedTasks} task remaining · That's okay!"
                        : 'All tasks complete!',
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onSurface.withAlpha(150),
                    ),
                  ),
                  const SizedBox(height: 12),
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
