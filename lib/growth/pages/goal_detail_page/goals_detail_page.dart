import 'package:flutter/material.dart';
import 'package:motiv8/models/goal.dart';
import 'package:provider/provider.dart';

import '../../../state/goals_controller.dart';
import '../../../state/tasks_controller.dart';
import 'milestone_timeline.dart';

class GoalDetailPage extends StatelessWidget {
  final String goalId;

  const GoalDetailPage({super.key, required this.goalId});

  @override
  Widget build(BuildContext context) {
    final goalsController = context.watch<GoalsController>();

    final goal = goalsController.getById(goalId);

    if (goal == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(height: 12),
                  Text('Goal', style: Theme.of(context).textTheme.titleSmall),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.more_horiz, color: Colors.black),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 18),
          _GoalHeader(goal),
          const SizedBox(height: 24),

          // ...goal!.milestones.map(
          //   (m) => MilestoneTimelineItem(
          //     milestone: m,
          //     index: goal.milestones.indexOf(m),
          //     isLast: goal.milestones.indexOf(m) == goal.milestones.length - 1,
          //   ),
          // ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: goal.milestones.length + 1,
            itemBuilder: (context, index) {
              final isAddButton = index == goal.milestones.length;

              if (isAddButton) {
                return AddMilestoneTimelineItem(
                  onAdd: () {
                    // open add milestone flow
                  },
                );
              }

              final milestone = goal.milestones[index];
              return MilestoneTimelineItem(milestone: milestone, index: index);
            },
          ),
        ],
      );
    }
  }
}

class _GoalHeader extends StatelessWidget {
  final Goal? goal;

  const _GoalHeader(this.goal);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                      goal?.title ?? 'Unknown Goal',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      goal?.description ?? 'No description provided.',
                      style: TextStyle(color: Colors.grey[700], height: 1.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(height: 32, thickness: 1.0),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Why this matters'.toUpperCase()),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text('"${goal?.direction}"'),
            ],
          ),
          Divider(height: 32, thickness: 1.0),
          Text(
            goal?.milestones.isEmpty ?? true
                ? 'No milestones yet. Start by adding a milestone to track your progress!'
                : "${TasksController().remainingTasksForGoal(goal!.id)} of ${goal?.milestones.length ?? 0} milestones reached",

            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
