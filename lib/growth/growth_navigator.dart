import 'package:flutter/material.dart';
import './growth_page.dart';
import 'pages/goals_page.dart';
import 'pages/goal_detail_page/goals_detail_page.dart';

class GrowthNavigator extends StatelessWidget {
  const GrowthNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/goals':
            return MaterialPageRoute(builder: (_) => const GoalsPage());

          case '/goal-details':
            final goalId = settings.arguments as String;
            return MaterialPageRoute(
              builder: (_) => GoalDetailPage(goalId: goalId),
            );

          case '/':
          default:
            return MaterialPageRoute(builder: (_) => const GrowthPage());
        }
      },
    );
  }
}
