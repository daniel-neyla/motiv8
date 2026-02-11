import 'milestone.dart';

class Goal {
  final String id;
  final String title;
  final String? direction;
  final String? description;
  final List<Milestone> milestones;

  Goal({
    required this.id,
    required this.title,
    required this.direction,
    required this.milestones,
    this.description,
  });
}
