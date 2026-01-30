class GrowthHabit {
  final String id;
  final String title;
  final String frequency; // 'Daily', 'Weekly'
  final String category; // 'Mental clarity', 'Physical health', etc.
  final int streak;
  final int bestStreak;
  final int rate; // Percentage
  final bool isCompletedToday;

  const GrowthHabit({
    required this.id,
    required this.title,
    required this.frequency,
    required this.category,
    required this.streak,
    required this.bestStreak,
    required this.rate,
    required this.isCompletedToday,
  });
}

final List<GrowthHabit> dummyHabits = [
  GrowthHabit(
    id: '1',
    title: 'Morning meditation',
    frequency: 'Daily',
    category: 'Mental clarity',
    streak: 12,
    bestStreak: 21,
    rate: 85,
    isCompletedToday: true,
  ),
  GrowthHabit(
    id: '2',
    title: '30 min reading',
    frequency: 'Daily',
    category: 'Learning',
    streak: 5,
    bestStreak: 14,
    rate: 72,
    isCompletedToday: false,
  ),
  GrowthHabit(
    id: '3',
    title: 'Evening walk',
    frequency: 'Daily',
    category: 'Physical health',
    streak: 8,
    bestStreak: 30,
    rate: 78,
    isCompletedToday: false,
  ),
  GrowthHabit(
    id: '4',
    title: 'Weekly review',
    frequency: 'Weekly',
    category: 'Build consistent habits',
    streak: 3,
    bestStreak: 8,
    rate: 65,
    isCompletedToday: false,
  ),
  GrowthHabit(
    id: '5',
    title: 'Journaling',
    frequency: 'Daily',
    category: 'Mental clarity',
    streak: 0,
    bestStreak: 7,
    rate: 45,
    isCompletedToday: false,
  ),
];
