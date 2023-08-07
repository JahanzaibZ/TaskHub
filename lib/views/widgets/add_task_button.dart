import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/task.dart';
import '../../viewmodels/tasks_provider.dart';

class AddTaskButton extends ConsumerWidget {
  const AddTaskButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var userTask = Task(
      name: 'EMPTY_TASK',
      description: '',
    );
    final formKey = GlobalKey<FormState>();
    final tasksNotifier = ref.read(tasksProvider.notifier);

    void onSaved() async {
      final isValid = formKey.currentState!.validate();
      if (isValid) {
        formKey.currentState!.save();
        await tasksNotifier.addTask(userTask);
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      }
    }

    return FloatingActionButton(
      onPressed: () => showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          {
            final viewInsets = MediaQuery.of(context).viewInsets;
            return Padding(
              padding: EdgeInsets.only(
                top: viewInsets.top,
                bottom: viewInsets.bottom,
                right: 15,
                left: 15,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.only(bottom: 10),
                      child: const Text('Name:'),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Task name cannot be empty';
                        } else if (value.length < 3) {
                          return 'Task name must be at least 3 characters long';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (newValue) =>
                          userTask = userTask.copyWith(name: newValue),
                    ),
                    Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text('Description (optional):'),
                    ),
                    TextFormField(
                      maxLines: 3,
                      onSaved: (newValue) =>
                          userTask = userTask.copyWith(description: newValue),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: ElevatedButton(
                        onPressed: onSaved,
                        child: const Text('Save'),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
      child: const Icon(Icons.add),
    );
  }
}
