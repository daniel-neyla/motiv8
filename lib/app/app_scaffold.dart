import 'package:flutter/material.dart';

import 'bottom_nav_bar.dart';
import '../growth/growth_navigator.dart';
import 'package:motiv8/today/today_view.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int activeIndex = 0;
  void onAdd() {
    // void add task overlay
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: colorScheme.surface,
      backgroundColor: const Color(0xFFF9F9F9),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: IndexedStack(
            index: activeIndex,

            children: const [TodayView(), GrowthNavigator()],
          ),
        ),
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
