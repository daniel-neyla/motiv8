import 'package:flutter/material.dart';
import 'widgets/reflection_banner.dart';
import 'widgets/growth_card.dart';
import 'pages/goals_page.dart';
import 'pages/habits_page.dart';
import 'pages/reflections_page.dart';
import 'pages/routines_page.dart';
import 'pages/patterns_insights_page.dart';

class GrowthPage extends StatefulWidget {
  const GrowthPage({super.key});

  @override
  State<GrowthPage> createState() => _GrowthPageState();
}

class _GrowthPageState extends State<GrowthPage> {
  bool _showReflectionBanner = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Header
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.spa_outlined, // Leaf icon approximation
                    color: colorScheme.primary,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Text('Growth Space', style: textTheme.headlineMedium),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Cultivate what matters to you.',
                style: textTheme.headlineSmall,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),

        // Reflection Banner
        if (_showReflectionBanner)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            sliver: SliverToBoxAdapter(
              child: ReflectionBanner(
                onOpen: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReflectionsPage(),
                    ),
                  );
                },
                onDismiss: () {
                  setState(() {
                    _showReflectionBanner = false;
                  });
                },
              ),
            ),
          ),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              GrowthCard(
                title: 'Goals',
                subtitle: 'Your paths with milestones & tasks',
                icon: const Icon(Icons.track_changes),
                trailing: _BadgeCount(count: 3),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GoalsPage()),
                  );
                },
              ),
              GrowthCard(
                title: 'Habits',
                subtitle: 'Recurring actions with streaks',
                icon: const Icon(Icons.cached),
                trailing: _BadgeCount(count: 5),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HabitsPage()),
                  );
                },
              ),
              GrowthCard(
                title: 'Routines',
                subtitle: 'Daily & weekly collections',
                icon: const Icon(Icons.list_alt),
                trailing: _BadgeCount(count: 2),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RoutinesPage(),
                    ),
                  );
                },
              ),
              GrowthCard(
                title: 'Patterns & Insights',
                subtitle: 'Reflections and mood over time',
                icon: const Icon(Icons.lightbulb_outline),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PatternsInsightsPage(),
                    ),
                  );
                },
              ),
              GrowthCard(
                title: 'Reflections',
                subtitle: 'Weekly & monthly lookbacks',
                icon: const Icon(Icons.edit_note),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReflectionsPage(),
                    ),
                  );
                },
              ),
            ]),
          ),
        ),

        // Growth Trail (Accordion style)
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.withAlpha(20)),
            ),
            child: Theme(
              data: Theme.of(
                context,
              ).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F0E6), // Light beige
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.inventory_2_outlined,
                    color: Color(0xFF8D7F70),
                  ),
                ),
                title: const Text(
                  'Growth Trail',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F1F1F),
                  ),
                ),
                subtitle: Text(
                  'Your past effort, when you want to look back',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "History content would go here",
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Footer "Growth Journey"
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F1ED),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your growth journey',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'Serif',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Everything here serves your real life. Create goals, build habits, design routines — all connected, all intentional.',
                    style: TextStyle(color: Colors.grey[700], height: 1.5),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 80)), // Bottom padding
      ],
    );
  }
}

class _BadgeCount extends StatelessWidget {
  final int count;
  const _BadgeCount({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: Text(
        count.toString(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}
