import '../utils/day_phase.dart';

class Task {
  final String id;
  final String title;
  final bool completed;
  final DayPhase dayPhase;
  final int order;

  Task({
    required this.id,
    required this.title,
    required this.completed,
    required this.dayPhase,
    required this.order,
  });

  Task copyWith({
    String? id,
    String? title,
    bool? completed,
    DayPhase? dayPhase,
    int? order,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      dayPhase: dayPhase ?? this.dayPhase,
      order: order ?? this.order,
    );
  }
}
