import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maiporarisu/data/controllers/user_request/user_request.dart';
import 'package:maiporarisu/ui/screens/schedule_screen/schedule_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userRequest = UserRequest();
    TextEditingController timeController = TextEditingController();
    TextEditingController taskController = TextEditingController();
    bool dataValidation() {
      if (timeController.text.trim() == '') {
        Get.snackbar('Task Time', 'Task Time is empty');
        return false;
      } else if (timeController.text.trim().length > 6) {
        Get.snackbar('Task Time', '6文字以内で設定してください');
        return false;
      } else if (taskController.text.trim() == '') {
        Get.snackbar('Task Name', 'Task Name is empty');
        return false;
      } else if (taskController.text.trim().length > 20) {
        Get.snackbar('Task Name', '20文字以内で設定してください');
        return false;
      }
      return true;
    }

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
            ),
            TextField(
              maxLines: 1,
              controller: timeController,
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Time',
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
            ),
            TextField(
              maxLines: 1,
              controller: taskController,
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Task Name',
              ),
            ),
            TextButton(
              onPressed: () {
                if (dataValidation()) {
                  userRequest.postTask(
                    timeController.text.trim(),
                    taskController.text.trim(),
                  );
                }
              },
              child: const Text('add'),
            ),
          ],
        ),
      ),
    );
  }
}
