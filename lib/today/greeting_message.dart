import 'package:flutter/material.dart';
import '../../utils/day_phase.dart';

class GreetingMessage extends StatelessWidget {
  const GreetingMessage({super.key});

  String _getGreeeting() {
    DayPhase currentPhase = getCurrentDayPhase(DateTime.now());
    if (currentPhase == DayPhase.morning) return 'Good morning';
    if (currentPhase == DayPhase.afternoon) return 'Good afternoon';
    if (currentPhase == DayPhase.evening) return 'Good evening';
    return 'Good night';
  }

  String _getWeekday() {
    final weekday = DateTime.now().weekday;
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  IconData _getIcon() {
    final hour = DateTime.now().hour;
    if (hour < 12) return Icons.wb_twilight_outlined;
    if (hour < 18) return Icons.wb_sunny_outlined;
    return Icons.bedtime_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              _getIcon(),
              color: Theme.of(context).colorScheme.primary,
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(
              '${_getGreeeting()}, Daniel.',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),

        const SizedBox(height: 8),
        Text(
          'Here is your ${_getWeekday()}.',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }
}
