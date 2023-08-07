import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodels/tasks_provider.dart';
import './widgets/add_task_button.dart';
import './widgets/task_list_tile.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key});

  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () => ref.read(tasksProvider.notifier).fetchTasks(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loadingTasks);
    final tasks = ref.watch(tasksProvider);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/icon.png',
          height: 30,
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : tasks.isEmpty
              ? const Center(
                  child: Text('You have no tasks, Create some!'),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Your Tasks:',
                            textScaleFactor: 1.5,
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: tasks.length,
                            itemBuilder: (ctx, index) {
                              return TaskListTile(userTask: tasks[index]);
                            }),
                      ],
                    ),
                  ),
                ),
      floatingActionButton: const AddTaskButton(),
    );
  }
}
