import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/task.dart';
import '../services/db_service.dart';

final loadingTasks = StateProvider<bool>(
  (ref) => true,
);

final tasksProvider = StateNotifierProvider<TasksNotifier, List<Task>>(
    (ref) => TasksNotifier(ref));

class TasksNotifier extends StateNotifier<List<Task>> {
  final Ref _ref;
  TasksNotifier(this._ref) : super([]);

  Future<void> fetchTasks() async {
    final isLoading = _ref.read(loadingTasks.notifier);
    isLoading.state = true;
    final tasksData = await DatabaseService.readData();
    final tasks = <Task>[];
    for (final task in tasksData) {
      tasks.add(
        Task(
            id: task['id'],
            name: task['name'],
            description: task['description']),
      );
    }
    state = tasks;
    isLoading.state = false;
  }

  Future<void> addTask(Task task) async {
    await DatabaseService.insertData({
      'name': task.name,
      'description': task.description,
    });
    await fetchTasks();
  }

  Future<void> removeTask(Task task) async {
    await DatabaseService.deleteData(task.id);
    await fetchTasks();
  }
}
