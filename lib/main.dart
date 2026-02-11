import 'package:provider/provider.dart';
import 'app/motiv8_app.dart';
import 'state/goals_controller.dart';
import 'state/tasks_controller.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GoalsController()),
        ChangeNotifierProvider(create: (_) => TasksController()),
      ],
      child: const Motiv8App(),
    ),
  );
}
