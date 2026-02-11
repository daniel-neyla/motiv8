import 'package:flutter/foundation.dart';
import '../models/task.dart';
import '../utils/day_phase.dart';

class TasksController extends ChangeNotifier {
  final List<Task> _tasks = [
    Task(
      id: '1',
      title: 'Meditate',
      completed: true,
      dayPhase: DayPhase.morning,
      order: 1,
    ),
    Task(
      id: '2',
      title: 'Read',
      completed: false,
      dayPhase: DayPhase.afternoon,
      order: 2,
    ),
    Task(
      id: '3',
      title: 'Exercise',
      completed: false,
      dayPhase: DayPhase.afternoon,
      order: 1,
      goalId: '2',
      milestoneId: 'm3',
    ),
    Task(
      id: '4',
      title: 'Journal',
      completed: true,
      dayPhase: DayPhase.evening,
      order: 1,
    ),
  ];

  List<Task> get tasks => List.unmodifiable(_tasks);

  // --- Queries ---
  List<Task> tasksForPhase(DayPhase phase) =>
      _tasks.where((t) => t.dayPhase == phase).toList();

  List<Task> get completed => _tasks.where((t) => t.completed).toList();

  List<Task> get unfinished => _tasks.where((t) => !t.completed).toList();

  // --- Mutations ---

  int generateId() {
    return tasks.length + 1;
  }

  void addTask(String title) {
    final DayPhase currentDayPhase = getCurrentDayPhase(DateTime.now());
    tasks.add(
      Task(
        id: generateId().toString(),
        title: title,
        completed: false,
        dayPhase: currentDayPhase,
        order: tasks.where((t) => t.dayPhase == currentDayPhase).length + 1,
      ),
    );
    notifyListeners();
  }

  void toggleTask(String taskId) {
    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index == -1) return;

    _tasks[index] = _tasks[index].copyWith(completed: !_tasks[index].completed);
    notifyListeners();
  }

  void moveTaskToPhase(String taskId, DayPhase phase) {
    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index == -1) return;

    _tasks[index] = _tasks[index].copyWith(dayPhase: phase);
    notifyListeners();
  }

  void reorderWithinPhase(DayPhase phase, Task dragged, Task target) {
    final phaseTasks = tasksForPhase(phase);
    final draggedIndex = phaseTasks.indexOf(dragged);
    final targetIndex = phaseTasks.indexOf(target);

    if (draggedIndex == -1 || targetIndex == -1) return;

    phaseTasks.removeAt(draggedIndex);
    phaseTasks.insert(targetIndex, dragged);

    int order = 0;
    for (final task in phaseTasks) {
      final idx = _tasks.indexWhere((t) => t.id == task.id);
      _tasks[idx] = task.copyWith(order: order++);
    }

    notifyListeners();
  }

  // --- Goal/Milestone related queries ---
  List<Task> tasksForGoal(String goalId) {
    return _tasks.where((t) => t.goalId == goalId).toList();
  }

  int remainingTasksForGoal(String goalId) {
    return _tasks.where((t) => t.goalId == goalId && !t.completed).length;
  }

  List<Task> tasksForMilestone(String milestoneId) {
    return _tasks.where((t) => t.milestoneId == milestoneId).toList();
  }

  bool isMilestoneCompleted(String milestoneId) {
    final milestoneTasks = _tasks
        .where((t) => t.milestoneId == milestoneId)
        .toList();

    if (milestoneTasks.isEmpty) return false;

    return milestoneTasks.every((t) => t.completed);
  }
}


  // void toggleTask(String taskId) {
  //   setState(() {
  //     tasks = tasks.map((task) {
  //       if (task.id == taskId) {
  //         return task.copyWith(completed: !task.completed);
  //       }
  //       return task;
  //     }).toList();
  //   });
  // }

  // void quickAddTask(String title) {
  //   setState(() {
  //     final DayPhase currentDayPhase = getCurrentDayPhase(DateTime.now());
  //     tasks.add(
  //       Task(
  //         id: generateId().toString(),
  //         title: title,
  //         completed: false,
  //         dayPhase: currentDayPhase,
  //         order: tasks.where((t) => t.dayPhase == currentDayPhase).length + 1,
  //       ),
  //     );
  //   });
  // }