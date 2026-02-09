import 'package:flutter/material.dart';
import '../models/goal.dart';
import '../models/milestone.dart';

class GoalsController extends ChangeNotifier {
  final List<Goal> _goals = [
    Goal(
      id: '1',
      title: 'Build Motiv8',
      direction: 'To create a system that helps me grow without pressure.',
      milestones: [Milestone(id: 'm1', title: 'Design data models', tasks: [])],
    ),
    Goal(
      id: '2',
      title: 'Exercise regularly',
      direction: 'To improve my physical and mental health.',
      milestones: [
        Milestone(id: 'm2', title: 'Go to the gym 3x a week', tasks: []),
      ],
    ),
    Goal(
      id: '3',
      title: 'Read more books',
      direction: 'To expand my knowledge and perspective.',
      milestones: [
        Milestone(id: 'm3', title: 'Read 1 book per month', tasks: []),
      ],
    ),
  ];

  List<Goal> get goals => _goals;

  void addGoal(Goal goal) {
    _goals.add(goal);
    notifyListeners();
  }

  Goal? getById(String id) {
    return _goals.firstWhere((g) => g.id == id);
  }
}
