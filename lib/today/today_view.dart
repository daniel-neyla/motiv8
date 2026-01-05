import 'package:flutter/material.dart';
import '../app/app_scaffold.dart';
import 'greeting_message.dart';
import 'direction_reminder.dart';
import 'tasks_section.dart';
import 'goal.dart';

class TodayView extends StatefulWidget {
  const TodayView({super.key});

  @override
  State<TodayView> createState() => _TodayViewState();
}

class _TodayViewState extends State<TodayView> {
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
        opacity = 0.2;
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
                  child: DirectionReminder(
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
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 12)),
              SliverToBoxAdapter(child: TasksSection()),
            ],
          ),
        ),
      ),
    );
  }
}
