import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maiporarisu/data/controllers/data_controller.dart';
import 'package:maiporarisu/ui/navigation/maiporarisu_navigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController timeController = TextEditingController();
    TextEditingController taskController = TextEditingController();
    bool dataValidation() {
      if (timeController.text.trim() == '') {
        Get.snackbar("Task Time", "Task Time is empty");
        return false;
      } else if (taskController.text.trim() == '') {
        Get.snackbar("Task Name", "Task Name is empty");
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
                hintText: "Time",
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
                hintText: "Task Name",
              ),
            ),
            TextButton(
              onPressed: () {
                if (dataValidation()) {
                  Get.find<DataController>().postData(
                    timeController.text.trim(),
                    taskController.text.trim(),
                  );
                  Get.to(() => const MaiporarisuNavigation());
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
