import 'task.dart';

enum CarryOverAction { carry, discard }

class CarryOverDecision {
  final Task task;
  CarryOverAction action;

  CarryOverDecision({
    required this.task,
    this.action = CarryOverAction.carry, // default = carry
  });
}
