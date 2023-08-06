import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/task.dart';
import '../viewmodels/tasks_provider.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textField = TextEditingController();
    final tasks = ref.watch(tasksProvider);
    final tasksNotifier = ref.read(tasksProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/icon.png',
          height: 30,
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            debugPrint(
                'Task ID: ${tasks[index].id}, Task Name: ${tasks[index].name}');
            return ListTile(
              title: Text(tasks[index].name),
              trailing: IconButton(
                onPressed: () => tasksNotifier.removeTask(tasks[index]),
                icon: const Icon(Icons.delete),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet<void>(
          context: context,
          builder: (context) {
            {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                child: Column(
                  children: [
                    Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text('Enter Task:'),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      controller: textField,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                        onPressed: () =>
                            tasksNotifier.addTask(Task(name: textField.text)),
                        child: const Text('Save'),
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
