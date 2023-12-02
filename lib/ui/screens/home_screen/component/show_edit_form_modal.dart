import 'package:flutter/material.dart';
import 'package:maiporarisu/data/model/task.dart';
import 'package:maiporarisu/data/service/user_request.dart';

void showEditFormModal(
  BuildContext context,
  UserRequest userRequest,
  Task task,
) {
  TextEditingController timeController = TextEditingController(text: task.time);
  TextEditingController nameController = TextEditingController(text: task.name);

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'タスクの名前'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: timeController,
                decoration: const InputDecoration(labelText: '日時'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  userRequest.updateTask(
                    task.id,
                    timeController.text,
                    nameController.text,
                    task.check,
                  );
                  Navigator.pop(context);
                },
                child: const Text('変更する'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
