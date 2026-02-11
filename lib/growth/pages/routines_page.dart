import 'package:flutter/material.dart';

class RoutinesPage extends StatelessWidget {
  const RoutinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        forceMaterialTransparency: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Routines',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Serif',
              ),
            ),
            Text(
              'Daily & weekly collections',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _RoutineCard(
            title: 'Morning Awakening',
            subtitle: '5 tasks · 15 mins',
            icon: Icons.wb_sunny_outlined,
            color: Colors.orange[100]!,
            tasks: const [
              'Hydrate',
              'Meditate',
              'Plan day',
              'Stretch',
              'Journal',
            ],
            isCompleted: true,
          ),
          const SizedBox(height: 16),
          _RoutineCard(
            title: 'Deep Work Block',
            subtitle: '3 tasks · 2 hours',
            icon: Icons.work_outline,
            color: Colors.blue[100]!,
            tasks: const ['Focus mode on', 'Clear desk', 'Start timer'],
            isCompleted: false,
          ),
          const SizedBox(height: 16),
          _RoutineCard(
            title: 'Evening Wind-down',
            subtitle: '4 tasks · 30 mins',
            icon: Icons.nightlight_outlined,
            color: Colors.indigo[100]!,
            tasks: const [
              'Digital sunset',
              'Reflection',
              'Prepare for tomorrow',
              'Read',
            ],
            isCompleted: false,
          ),
        ],
      ),
    );
  }
}

class _RoutineCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final List<String> tasks;
  final bool isCompleted;

  const _RoutineCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.tasks,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withAlpha(20)),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.black87),
            ),
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(subtitle),
            trailing: isCompleted
                ? const Icon(Icons.check_circle, color: Color(0xFF4A7A5E))
                : const Icon(Icons.chevron_right, color: Colors.grey),
          ),
          if (!isCompleted)
            Padding(
              padding: const EdgeInsets.fromLTRB(72, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  ...tasks.map(
                    (task) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.radio_button_unchecked,
                            size: 14,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Text(task, style: TextStyle(color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
