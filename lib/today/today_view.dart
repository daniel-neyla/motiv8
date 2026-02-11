import 'package:flutter/material.dart';
import '../state/goals_controller.dart';
import '../state/tasks_controller.dart';
import '../models/task.dart';
import 'package:provider/provider.dart';
import '../utils/day_phase.dart';
import '../models/day_review.dart';
import '../content/quotes/quotes_service.dart';
import 'today_open_view.dart';

enum TodayStatus { open, closed }

class TodayView extends StatefulWidget {
  const TodayView({super.key});

  @override
  State<TodayView> createState() => _TodayViewState();
}

class _TodayViewState extends State<TodayView> {
  int taskId = 5;
  TodayStatus todayStatus = TodayStatus.open;
  bool isCloseDayOverlayOpen = false;

  void closeDay() {
    setState(() {
      todayStatus = TodayStatus.closed;
    });
  }

  DayReview buildDayReview(List<Task> tasks) {
    final completed = tasks.where((t) => t.completed).toList();

    final phaseCounts = <DayPhase, int>{};

    for (final task in completed) {
      phaseCounts[task.dayPhase] = (phaseCounts[task.dayPhase] ?? 0) + 1;
    }

    final mostProductivePhase = phaseCounts.entries.isEmpty
        ? DayPhase
              .morning // fallback
        : phaseCounts.entries.reduce((a, b) => a.value >= b.value ? a : b).key;

    return DayReview(
      numOfTasks: tasks.length,
      completedTasks: completed.length,
      mostProductivePhase: mostProductivePhase,
      quote: QuoteService.randomQuote(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final goals = context.watch<GoalsController>().goals;
    final tasksController = context.watch<TasksController>();
    final tasks = tasksController.tasks;
    return todayStatus == TodayStatus.open
        ? TodayOpenView(
            tasks: tasks,
            goals: goals,
            onToggleTask: tasksController.toggleTask,
            onSubmitTask: tasksController.addTask,
            onCloseDay: closeDay,

            review: buildDayReview(tasks),
          )
        : Center(child: Text('Closed Today'));
  }
}
