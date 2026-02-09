import 'package:flutter/material.dart';
import 'greeting_message.dart';
import 'direction_reminder.dart';
import 'task_section/tasks_section.dart';
import 'close_day/close_day_button.dart';
import '../models/goal.dart';
import '../models/task.dart';
import '../models/day_review.dart';

class TodayOpenView extends StatefulWidget {
  final List<Goal> goals;
  final List<Task> tasks;
  final Function(String) toggleTask;
  final Function(String) quickAddTask;
  final VoidCallback onCloseDay;

  final DayReview review;
  const TodayOpenView({
    super.key,
    required this.goals,
    required this.tasks,
    required this.toggleTask,
    required this.quickAddTask,
    required this.onCloseDay,
    required this.review,
  });
  @override
  State<TodayOpenView> createState() => _TodayOpenViewState();
}

class _TodayOpenViewState extends State<TodayOpenView> {
  final ScrollController _scrollController = ScrollController();
  double _directionOpacity = 1.0;

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
      child: todayOpenContent(),
    );
  }

  Widget todayOpenContent() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: CustomScrollView(
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 24)),
            SliverToBoxAdapter(child: const GreetingMessage()),
            SliverToBoxAdapter(child: SizedBox(height: 12)),
            SliverToBoxAdapter(
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: _directionOpacity,
                child: DirectionReminder(goals: widget.goals),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 24)),
            SliverToBoxAdapter(
              child: TasksSection(
                tasks: widget.tasks,
                onToggleTask: widget.toggleTask,
                onSubmit: widget.quickAddTask,
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              sliver: SliverToBoxAdapter(
                child: CloseDayButton(
                  review: widget.review,
                  onCloseDay: widget.onCloseDay,

                  unfinishedTasks: widget.tasks
                      .where((t) => !t.completed)
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
