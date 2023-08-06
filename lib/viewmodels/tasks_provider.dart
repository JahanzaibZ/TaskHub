import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/task.dart';
import '../services/db_service.dart';

final tasksProvider =
    StateNotifierProvider<TasksNotifier, List<Task>>((ref) => TasksNotifier());

class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier() : super([]);

  Future<void> fetchTasks() async {
    final tasksData = await DatabaseService.readData();
    final tasks = <Task>[];
    for (final task in tasksData) {
      tasks.add(Task(id: task['id'], name: task['name']));
    }
    state = tasks;
  }

  Future<void> addTask(Task task) async {
    await DatabaseService.insertData({
      'name': task.name,
    });
    await fetchTasks();
  }

  Future<void> removeTask(Task task) async {
    await DatabaseService.deleteData(task.id);
    await fetchTasks();
  }
}
