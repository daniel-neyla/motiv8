import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';
import '../growth/growth_page.dart';
import 'package:motiv8/today/today_view.dart';
import 'quick_add_page.dart';
import '../growth/widgets/create_habit_popover.dart';
import '../growth/widgets/create_goal_popover.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int activeIndex = 0;
  void onAdd() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => QuickAddPage(
        onAddHabit: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const CreateHabitPopover(),
          );
        },
        onAddGoal: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const CreateGoalPopover(),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Motiv8', style: Theme.of(context).textTheme.titleLarge),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 1,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
      ),
      body: IndexedStack(
        index: activeIndex,
        children: const [TodayView(), GrowthPage()],
      ),

      bottomNavigationBar: BottomNavBar(
        activeIndex: activeIndex,
        onTap: (index) {
          setState(() => activeIndex = index);
        },
        onAdd: onAdd,
      ),
    );
  }
}
