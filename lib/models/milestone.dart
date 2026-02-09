import 'Task.dart';

class Milestone {
  final String id;
  final String title;
  final List<Task> tasks;

  Milestone({required this.id, required this.title, required this.tasks});

  bool get isCompleted => tasks.isNotEmpty && tasks.every((t) => t.completed);
}
