import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/task.dart';
import '../../viewmodels/tasks_provider.dart';

class TaskListTile extends ConsumerWidget {
  final Task userTask;

  const TaskListTile({required this.userTask, super.key});

  void taskDetails(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Align(
              alignment: Alignment.center,
              child: Text(
                userTask.name,
                textScaleFactor: 1.5,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                userTask.description,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksNotifier = ref.read(tasksProvider.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        onTap: () => taskDetails(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        tileColor: Theme.of(context).colorScheme.brightness == Brightness.light
            ? Colors.white
            : Colors.black,
        title: Text(userTask.name),
        subtitle: Text(
          userTask.description,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodySmall!.color!.withAlpha(150),
          ),
        ),
        trailing: IconButton(
          onPressed: () => tasksNotifier.removeTask(userTask),
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }
}
