enum DayPhase { morning, afternoon, evening, night }

DayPhase getCurrentDayPhase(DateTime now) {
  final hour = now.hour;

  if (hour >= 5 && hour < 12) {
    return DayPhase.morning;
  } else if (hour >= 12 && hour < 17) {
    return DayPhase.afternoon;
  } else if (hour >= 17 && hour < 24) {
    return DayPhase.evening;
  } else {
    return DayPhase.night;
  }
}
