import 'package:flutter/material.dart';
import '../app/app_scaffold.dart';
import 'greeting_message.dart';
import 'direction_reminder.dart';
import 'tasks_section.dart';
import '../models/goal.dart';
import '../models/task.dart';
import '../utils/day_phase.dart';
import 'close_day_button.dart';

class TodayView extends StatefulWidget {
  const TodayView({super.key});

  @override
  State<TodayView> createState() => _TodayViewState();
}

class _TodayViewState extends State<TodayView> {
  final ScrollController _scrollController = ScrollController();
  double _directionOpacity = 1.0;
  int taskId = 5;

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
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final offset = _scrollController.offset;

      // 👇 delay: greeting scrolls away first
      const fadeStart = 80.0;
      const fadeEnd = 200.0;

      double opacity;

      if (offset <= fadeStart) {
        opacity = 1.0;
      } else if (offset >= fadeEnd) {
        opacity = 0.1;
      } else {
        opacity = 1 - (offset - fadeStart) / (fadeEnd - fadeStart);
      }

      setState(() {
        _directionOpacity = opacity;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: taskSection(),
    );
  }

  Widget taskSection() {
    return AppScaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(child: const GreetingMessage()),
              SliverToBoxAdapter(child: SizedBox(height: 12)),
              SliverToBoxAdapter(
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 200),
                  opacity: _directionOpacity,
                  child: DirectionReminder(goals: goals),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(
                child: TasksSection(
                  tasks: tasks,
                  onToggleTask: toggleTask,
                  onSubmit: quickAddTask,
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                sliver: SliverToBoxAdapter(
                  child: CloseDayButton(
                    tasksComplete: tasks.where((task) => task.completed).length,
                    numOfTasks: tasks.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
