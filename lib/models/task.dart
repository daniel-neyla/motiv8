import '../utils/day_phase.dart';

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

  Task copyWith({
    String? id,
    String? title,
    bool? completed,
    DayPhase? dayPhase,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      dayPhase: dayPhase ?? this.dayPhase,
    );
  }
}
