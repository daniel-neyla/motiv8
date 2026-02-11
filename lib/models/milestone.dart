import 'Task.dart';

class Milestone {
  final String id;
  final String title;
  final String goalId;

  Milestone({required this.id, required this.title, required this.goalId});

  // bool get isCompleted => tasks.isNotEmpty && tasks.every((t) => t.completed);
}
