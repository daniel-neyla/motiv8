import 'milestone.dart';

class Goal {
  final String id;
  final String title;
  final String direction;
  final List<Milestone> milestones;

  Goal({
    required this.id,
    required this.title,
    required this.direction,
    required this.milestones,
  });

  double get progress {
    if (milestones.isEmpty) return 0;
    final completed = milestones.where((m) => m.isCompleted).length;
    return completed / milestones.length;
  }

  int get tasksRemaining {
    int remaining = 0;
    for (final m in milestones) {
      remaining += m.tasks.where((t) => !t.completed).length;
    }
    return remaining;
  }
}
