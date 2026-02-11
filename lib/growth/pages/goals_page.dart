import 'package:flutter/material.dart';
import '../../models/goal.dart';
import 'package:provider/provider.dart';
import '../../state/goals_controller.dart';
import '../../state/tasks_controller.dart';
import 'goal_detail_page/goals_detail_page.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final goals = context.watch<GoalsController>().goals;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
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
            Text('Goals', style: textTheme.titleLarge),
            Text(
              'Your paths forward',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: const Color(0xFF4A7A5E),
              radius: 18,
              child: const Icon(Icons.add, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemCount: goals.length,
        itemBuilder: (context, index) {
          final goal = goals[index];
          return InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => GoalDetailPage(goalId: goal.id),
                ),
              );
            },
            child: _GoalDetailCard(goal: goal),
          );
        },
      ),
    );
  }
}

class _GoalDetailCard extends StatelessWidget {
  final Goal goal;

  const _GoalDetailCard({required this.goal});

  double get progress {
    if (goal.milestones.isEmpty) return 0.0;
    final completedMilestones = goal.milestones
        .where((m) => TasksController().isMilestoneCompleted(m.id))
        .length;
    return completedMilestones / goal.milestones.length;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF5F1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.track_changes,
                    color: Color(0xFF4A7A5E),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        goal.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Serif',
                        ),
                      ),
                      const SizedBox(height: 4),

                      Text(
                        goal.description ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey[600], height: 1.4),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 24),

            // Progress Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Progress',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[500],
                  ),
                ),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A7A5E),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: const Color(0xFFEFEBE4), // Beige-ish grey
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF5A8F70),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Milestones
            Text(
              'MILESTONES',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey[500],
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            ...List.generate(goal.milestones.length, (index) {
              final milestone = goal.milestones[index];
              final isCompleted = TasksController().isMilestoneCompleted(
                milestone.id,
              );
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Icon(
                      isCompleted
                          ? Icons.check_circle_outline
                          : Icons.radio_button_unchecked,
                      color: isCompleted
                          ? const Color(0xFF4A7A5E)
                          : Colors.grey[400],
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        milestone.title,
                        style: TextStyle(
                          decoration: isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                          color: isCompleted
                              ? Colors.grey[400]
                              : const Color(0xFF1F1F1F),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            if (goal.milestones.length > 3) ...[
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Text(
                  '+1 more',
                  style: TextStyle(color: Colors.grey[500], fontSize: 13),
                ),
              ),
            ],

            Divider(height: 32, color: Colors.grey[200]),

            Text(
              '${TasksController().remainingTasksForGoal(goal.id)} tasks remaining', // Hardcoded for visual matching
              style: TextStyle(color: Colors.grey[500], fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
