import 'package:motiv8/utils/day_phase.dart';

class DayReview {
  final int completedTasks;
  final DayPhase mostProductivePhase;
  final String quote;
  final int numOfTasks;

  DayReview({
    required this.numOfTasks,
    required this.completedTasks,
    required this.mostProductivePhase,
    required this.quote,
  });
}
