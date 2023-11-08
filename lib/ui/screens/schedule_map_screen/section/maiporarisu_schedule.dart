import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maiporarisu/data/task/task_model.dart';
import 'package:maiporarisu/ui/screens/schedule_map_screen/component/task_item.dart';
import 'package:maiporarisu/ui/styles/size.dart';

class MaiporarisuSchedule extends ConsumerWidget {
  const MaiporarisuSchedule({
    super.key,
    required this.maxHeight,
    required this.tasks,
  });

  final double maxHeight;
  final List<Task> tasks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 32,
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Theme.of(context)
                          .colorScheme
                          .outline
                          .withOpacity(0.8),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 24),
                      Text(
                        'タスク',
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Text(
                        '${tasks.length} 個',
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert_rounded),
                        disabledColor: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.3),
                        padding: const EdgeInsets.all(16.0),
                      ),
                      const SizedBox(width: 4),
                    ],
                  ),
                ],
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: Theme.of(context).colorScheme.outline.withOpacity(0.25),
              ),
              if (tasks.isEmpty)
                Column(
                  children: [
                    const SizedBox(height: 32),
                    Icon(
                      Icons.done_all_rounded,
                      size: 120,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.3),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '今日のタスクはありません',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
              top: MaiporarisuSize.sheetHandleHeight,
            ),
            height: maxHeight - MaiporarisuSize.sheetHandleHeight,
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              itemCount: tasks.length,
              itemBuilder: (context, i) {
                return Material(
                  color: Colors.transparent,
                  child: TaskItem(task: tasks[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
