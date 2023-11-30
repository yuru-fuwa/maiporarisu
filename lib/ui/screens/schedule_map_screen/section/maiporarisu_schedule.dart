import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:maiporarisu/data/task/task_model.dart';
import 'package:maiporarisu/ui/screens/schedule_map_screen/component/task_item.dart';
import 'package:maiporarisu/ui/screens/schedule_map_screen/hook/use_schedule_map_screen_state.dart';
import 'package:maiporarisu/ui/styles/physics.dart';
import 'package:maiporarisu/ui/styles/size.dart';

class MaiporarisuSchedule extends HookWidget {
  const MaiporarisuSchedule({
    super.key,
    required this.maxHeight,
    required this.tasks,
    required this.draggableScrollableController,
  });

  final double maxHeight;
  final List<Task> tasks;
  final DraggableScrollableController draggableScrollableController;

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    var tempOffset = 0.0;
    var update = DateTime.now();

    ScheduleMapScreenState state = useScheduleMapScreenState(
      dateTime: DateTime.now(),
      timeOfDay: TimeOfDay.now(),
    );

    tasks.sort((a, b) => a.time.compareTo(b.time));
    List<Task> selectedDateTasks = tasks.where((task) {
      return task.time.contains(state.compareDate);
    }).toList();

    controller.addListener(() {
      if (tempOffset == 0 &&
          controller.offset < 0 &&
          DateTime.now().difference(update) >
              const Duration(milliseconds: 10)) {
        draggableScrollableController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      }
      tempOffset = controller.offset;
      update = DateTime.now();
    });

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
                        '${state.displayDate}のタスク',
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Text(
                        '${selectedDateTasks.length} 個',
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            '${state.dateTime.day}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(DateTime.now().year),
                            lastDate: DateTime(DateTime.now().year + 1),
                          ).then((newDateTime) {
                            if (newDateTime != null) {
                              state.handleDateTimeState(newDateTime);
                            }
                          });
                        },
                        icon: const Icon(Icons.calendar_today),
                        disabledColor: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.3),
                        padding: const EdgeInsets.all(16.0),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: Theme.of(context).colorScheme.outline.withOpacity(0.25),
              ),
              if (selectedDateTasks.isEmpty)
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
                      '${state.displayDate}のタスクはありません',
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
              controller: controller,
              physics: const MaiporarisuScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                0,
                8,
                0,
                20 + MediaQuery.of(context).viewPadding.bottom,
              ),
              itemCount: selectedDateTasks.length,
              itemBuilder: (context, i) {
                return TaskItem(task: selectedDateTasks[i]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
