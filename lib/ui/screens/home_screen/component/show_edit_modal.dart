import 'package:flutter/material.dart';
import 'package:maiporarisu/data/model/task.dart';
import 'package:maiporarisu/data/service/user_request.dart';
import 'package:maiporarisu/ui/screens/home_screen/component/show_edit_form_modal.dart';

void ShowEditModal(BuildContext context, UserRequest userRequest, Task task) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 32),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('編集'),
            onTap: () {
              Navigator.pop(context);
              ShowEditFormModal(context, userRequest, task);
            },
          ),
          const SizedBox(height: 32),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('削除'),
            onTap: () {
              userRequest.deleteTask(task.id);
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 32),
        ],
      );
    },
  );
}
