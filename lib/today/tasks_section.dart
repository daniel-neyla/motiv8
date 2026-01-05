import 'package:flutter/material.dart';
import 'time_zone_section.dart';

class TasksSection extends StatelessWidget {
  const TasksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Opacity(
          opacity: 0.6,
          child: Text(
            'To Do · 2',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),

        TimeZoneSection(
          title: 'Morning',
          state: TimeZoneStates.past,
          emoji: '☀️',
        ),
        TimeZoneSection(
          title: 'Afternoon',
          state: TimeZoneStates.active,
          emoji: '🌤️',
        ),
        TimeZoneSection(
          title: 'Evening',
          state: TimeZoneStates.future,
          emoji: '🌙',
        ),
      ],
    );
  }
}
