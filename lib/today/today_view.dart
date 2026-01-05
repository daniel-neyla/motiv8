import 'package:flutter/material.dart';
import '../app/app_scaffold.dart';

class TodayView extends StatelessWidget {
  const TodayView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(
        child: Text(
          'Your day starts here!',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
