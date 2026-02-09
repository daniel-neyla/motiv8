import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/goal.dart';

class DirectionReminder extends StatelessWidget {
  final List<Goal> goals;
  const DirectionReminder({super.key, required this.goals});
  static const numberOfGoalsToShow = 3;
  @override
  Widget build(BuildContext context) {
    final hasGoals = goals.isNotEmpty;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      constraints: const BoxConstraints(minHeight: 160),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(20),

        child: Stack(
          children: [
            Positioned(
              top: -40,
              right: -40,
              child: Opacity(
                opacity: 0.05,
                child: SvgPicture.asset(
                  'assets/icons/compass-rose.svg',
                  width: 180,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Why today matters',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 12),
                  if (hasGoals)
                    ...goals
                        .take(numberOfGoalsToShow)
                        .map(
                          (goal) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  goal.title,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  goal.direction,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.color
                                            ?.withValues(alpha: 0.6),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Goals give direction to your day.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () {
                            print('Add goals');
                          },
                          child: const Text('Add Goals'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
