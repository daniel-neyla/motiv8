enum DayPhase { morning, afternoon, evening }

class Task {
  final String id;
  final String title;
  final bool completed;
  final DayPhase dayPhase;

  Task({
    required this.id,
    required this.title,
    required this.completed,
    required this.dayPhase,
  });
}
