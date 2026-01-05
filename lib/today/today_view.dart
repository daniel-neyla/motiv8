import 'package:flutter/material.dart';
import '../app/app_scaffold.dart';
import 'greeting_message.dart';
import 'direction_reminder.dart';
import 'tasks_section.dart';
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
              Goal(
                'Build Motiv8',
                'To create a system that helps me grow without pressure.',
              ),
              Goal(
                'Exercise regularly',
                'To improve my physical and mental health.',
              ),
              Goal(
                'Read more books',
                'To expand my knowledge and perspective.',
              ),
            ],
          ),
          SizedBox(height: 12),
          TasksSection(),
        ],
      ),
    );
  }
}
