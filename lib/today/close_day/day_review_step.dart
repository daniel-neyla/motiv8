import 'package:flutter/material.dart';
import 'package:motiv8/models/day_review.dart';

class DayReviewStep extends StatelessWidget {
  final DayReview review;
  const DayReviewStep({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        Column(
          children: [
            Text(
              "${review.completedTasks}",
              style: TextStyle(
                fontSize: textTheme.headlineMedium?.fontSize,
                color: colorScheme.primary,
              ),
            ),
            Text("tasks completed", style: textTheme.bodyMedium),
          ],
        ),

        const SizedBox(height: 32),

        Column(
          children: [
            Text("Most productive phase", style: textTheme.bodyMedium),
            const SizedBox(height: 4),
            Text(review.mostProductivePhase.name, style: textTheme.titleMedium),
          ],
        ),

        const SizedBox(height: 48),

        Text(
          "“${review.quote}”",
          style: textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
