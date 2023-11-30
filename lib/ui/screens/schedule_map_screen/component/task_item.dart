import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:maiporarisu/data/model/task.dart';
import 'package:maiporarisu/maiporarisu_util.dart';

class TaskItem extends HookWidget {
  final Task task;

  const TaskItem({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final done = useState(task.check);
    return Card(
      elevation: 0,
      color: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          done.value = !done.value;
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(
                done.value
                    ? Icons.check_box_outlined
                    : Icons.check_box_outline_blank_outlined,
                color:
                    done.value ? Theme.of(context).colorScheme.primary : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  task.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                MaiporarisuUtil.getTimeDifference(task.taskDateTime),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
