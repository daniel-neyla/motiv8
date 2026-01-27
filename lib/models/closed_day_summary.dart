import 'task.dart';

class ClosedDaySummary {
  final String mood;
  final int totalTasks;
  final int completedTasks;
  final List<Task> tomorrowTasks;

  ClosedDaySummary({
    required this.mood,
    required this.totalTasks,
    required this.completedTasks,
    required this.tomorrowTasks,
  });
}
