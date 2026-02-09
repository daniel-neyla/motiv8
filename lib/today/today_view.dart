import 'package:flutter/material.dart';
import '../models/goal.dart';
import '../models/task.dart';
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

  int generateId() {
    return taskId++;
  }

  List<Goal> goals = [
    Goal(
      '1',
      'Build Motiv8',
      'To create a system that helps me grow without pressure.',
    ),
    Goal(
      '2',
      'Exercise regularly',
      'To improve my physical and mental health.',
    ),
    Goal('3', 'Read more books', 'To expand my knowledge and perspective.'),
  ];

  List<Task> tasks = [
    Task(
      id: '1',
      title: 'Meditate',
      completed: true,
      dayPhase: DayPhase.morning,
      order: 1,
    ),
    Task(
      id: '2',
      title: 'Read',
      completed: false,
      dayPhase: DayPhase.afternoon,
      order: 2,
    ),
    Task(
      id: '3',
      title: 'Exercise',
      completed: false,
      dayPhase: DayPhase.afternoon,
      order: 1,
    ),
    Task(
      id: '4',
      title: 'Journal',
      completed: true,
      dayPhase: DayPhase.evening,
      order: 1,
    ),
  ];

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

  void toggleTask(String taskId) {
    setState(() {
      tasks = tasks.map((task) {
        if (task.id == taskId) {
          return task.copyWith(completed: !task.completed);
        }
        return task;
      }).toList();
    });
  }

  void quickAddTask(String title) {
    setState(() {
      final DayPhase currentDayPhase = getCurrentDayPhase(DateTime.now());
      tasks.add(
        Task(
          id: generateId().toString(),
          title: title,
          completed: false,
          dayPhase: currentDayPhase,
          order: tasks.where((t) => t.dayPhase == currentDayPhase).length + 1,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return todayStatus == TodayStatus.open
        ? TodayOpenView(
            tasks: tasks,
            goals: goals,
            toggleTask: toggleTask,
            quickAddTask: quickAddTask,
            onCloseDay: closeDay,

            review: buildDayReview(tasks),
          )
        : Center(child: Text('Closed Today'));
  }
}
