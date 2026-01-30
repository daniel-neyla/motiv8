class GrowthGoal {
  final String id;
  final String title;
  final String description;
  final double progress; // 0.0 to 1.0
  final List<String> milestones;
  final List<bool> milestoneCompletion; // Parallel to milestones

  const GrowthGoal({
    required this.id,
    required this.title,
    required this.description,
    required this.progress,
    required this.milestones,
    required this.milestoneCompletion,
  });
}

final List<GrowthGoal> dummyGoals = [
  GrowthGoal(
    id: '1',
    title: 'Build consistent habits',
    description:
        'Create a foundation of daily practices that support my wellbeing',
    progress: 0.65,
    milestones: [
      'Establish morning routine',
      '30-day meditation streak',
      'Weekly review habit',
      'Track sleep schedule',
    ],
    milestoneCompletion: [true, true, false, false],
  ),
  GrowthGoal(
    id: '2',
    title: 'Improve mental clarity',
    description:
        'Reduce mental clutter and increase focus through intentional practices',
    progress: 0.40,
    milestones: [
      'Digital declutter',
      'Daily journaling for 2 weeks',
      'Mindfulness course complete',
    ],
    milestoneCompletion: [true, false, false],
  ),
  GrowthGoal(
    id: '3',
    title: 'Physical health foundation',
    description: 'Build sustainable movement and nutrition habits',
    progress: 0.25,
    milestones: [
      'Daily movement habit',
      'Meal planning routine',
      'Sleep schedule optimization',
    ],
    milestoneCompletion: [true, false, false],
  ),
];
