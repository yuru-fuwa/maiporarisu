import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:maiporarisu/data/model/task.dart';
import 'package:maiporarisu/data/service/user_request.dart';
import 'package:maiporarisu/ui/screens/add_task_screen/add_task_screen.dart';
import 'package:maiporarisu/ui/screens/home_screen/component/show_edit_modal.dart';
import 'package:maiporarisu/ui/screens/schedule_map_screen/component/task_item.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userRequest = UserRequest(isMock: true);

    return FutureBuilder(
      future: userRequest.getAllTasks(),
      builder: (context, snapshot) {
        final taskList = snapshot.data ?? <Task>[];

        if (taskList.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('タスク一覧'),
            ),
            body: Container(
              alignment: Alignment.center,
              child: const Text('タスクがありません'),
            ),
            floatingActionButton: FloatingActionButton.extended(
              icon: const Icon(Icons.add_rounded),
              label: const Text('タスクを追加'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddTaskScreen(),
                  ),
                );
              },
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('タスク一覧'),
          ),
          body: ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, i) {
              return Card(
                child: Column(
                  children: [
                    Container(
                      height: 24,
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          ShowEditModal(context, userRequest, taskList[i]);
                        },
                        icon: const Icon(Icons.more_horiz),
                        iconSize: 24,
                      ),
                    ),
                    TaskItem(task: taskList[i]),
                    const SizedBox(height: 18),
                  ],
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            icon: const Icon(Icons.add_rounded),
            label: const Text('タスクを追加'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddTaskScreen()),
              );
            },
          ),
        );
      },
    );
  }
}
