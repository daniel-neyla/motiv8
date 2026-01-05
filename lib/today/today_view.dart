import 'package:flutter/material.dart';
import '../app/app_scaffold.dart';
import 'greeting_message.dart';
import 'direction_reminder.dart';
import 'goal.dart';

class TodayView extends StatelessWidget {
  const TodayView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, kToolbarHeight + 16, 16, 16),
        children: const [
          SizedBox(height: 64),
          GreetingMessage(),
          SizedBox(height: 12),
          DirectionReminder(
            goals: [
              Goal('Finish the project report', 'Work'),
              Goal('Go for a 30-minute run', 'Health'),
              Goal('Read 20 pages of a book', 'Personal Growth'),
            ],
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
