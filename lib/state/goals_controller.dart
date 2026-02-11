import 'package:flutter/material.dart';
import '../models/goal.dart';
import '../models/milestone.dart';

class GoalsController extends ChangeNotifier {
  final List<Goal> _goals = [
    Goal(
      id: '1',
      title: 'Build Motiv8',
      direction: 'To create a system that helps me grow without pressure.',
      description:
          'Motiv8 is a personal growth app that focuses on progress, not perfection. It helps you set meaningful goals, break them down into milestones, and track your daily tasks in a way that encourages consistency and learning.',
      milestones: [
        Milestone(id: 'm1', title: 'Design data models', goalId: '1'),
        Milestone(id: 'm2', title: 'Implement core features', goalId: '1'),
      ],
    ),
    Goal(
      id: '2',
      title: 'Exercise regularly',
      direction: 'To improve my physical and mental health.',
      description:
          'Regular exercise boosts energy, reduces stress, and enhances overall well-being. My aim is to find enjoyable activities that keep me moving consistently.',
      milestones: [
        Milestone(id: 'm3', title: 'Go to the gym 3x a week', goalId: '2'),
      ],
    ),
    Goal(
      id: '3',
      title: 'Read more books',
      direction: 'To expand my knowledge and perspective.',
      description:
          'Reading is a powerful way to learn and grow. I want to cultivate a habit of reading regularly, exploring a variety of genres and topics that interest me.',
      milestones: [
        Milestone(id: 'm4', title: 'Read 1 book per month', goalId: '3'),
      ],
    ),
  ];

  List<Goal> get goals => List.unmodifiable(_goals);

  void addGoal(Goal goal) {
    _goals.add(goal);
    notifyListeners();
  }

  Goal? getById(String id) {
    try {
      return _goals.firstWhere((g) => g.id == id);
    } catch (_) {
      return null;
    }
  }
}
