import 'package:flutter/material.dart';
import 'package:maiporarisu/data/model/task.dart';

void ShowEditModal(BuildContext context, Task task) {
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
            },
          ),
          const SizedBox(height: 32),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('削除'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 32),
        ],
      );
    },
  );
}
