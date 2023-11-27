import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:maiporarisu/data/controllers/user_request/user_request.dart';
import 'package:maiporarisu/ui/screens/home_screen/hook/use_home_screen_state.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userRequest = UserRequest();
    TextEditingController taskController = TextEditingController();
    bool taskValidation() {
      if (taskController.text.trim().isEmpty) {
        return false;
      }
      return true;
    }

    HomeScreenState state = useHomeScreenState(
      dateTime: DateTime.now(),
      timeOfDay: TimeOfDay.now(),
    );

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
            ElevatedButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: state.dateTime,
                  firstDate: DateTime(DateTime.now().year),
                  lastDate: DateTime(DateTime.now().year + 1),
                ).then((newDateTime) {
                  if (newDateTime != null) {
                    state.handleDateTimeState(newDateTime);
                  }
                });
              },
              child: Text(
                '${state.dateTime.year.toString()}.${state.dateTime.month.toString().padLeft(2, '0')}.${state.dateTime.day.toString().padLeft(2, '0')}',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showTimePicker(
                  context: context,
                  initialTime: state.timeOfDay,
                ).then((newTimeOfDay) {
                  if (newTimeOfDay != null) {
                    state.handleTimeOfDayState(newTimeOfDay);
                  }
                });
              },
              child: Text(
                '${state.timeOfDay.hour.toString().padLeft(2, '0')}:${state.timeOfDay.minute.toString().padLeft(2, '0')}',
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
                if (taskValidation()) {
                  userRequest.postTask(
                    DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(
                      DateTime(
                        state.dateTime.year,
                        state.dateTime.month,
                        state.dateTime.day,
                        state.timeOfDay.hour,
                        state.timeOfDay.minute,
                      ),
                    ),
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
