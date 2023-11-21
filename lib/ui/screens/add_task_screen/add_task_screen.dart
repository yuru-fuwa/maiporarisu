import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:maiporarisu/data/controllers/user_request/user_request.dart';
import 'package:maiporarisu/ui/component/unfocus.dart';
import 'package:maiporarisu/ui/screens/home_screen/hook/use_home_screen_state.dart';

class AddTaskScreen extends HookWidget {
  const AddTaskScreen({super.key});

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

    return Unfocus(
      child: Scaffold(
        resizeToAvoidBottomInset: false, //キーボードによって画面サイズを変更させない
        appBar: AppBar(
          backgroundColor: Color.alphaBlend(
            Theme.of(context).colorScheme.primary.withOpacity(0.08),
            Theme.of(context).colorScheme.background,
          ),
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          title: const Text('タスクを追加'),
        ),
        body: Container(
          padding: const EdgeInsets.all(64),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              Row(
                children: <Widget>[
                  const Icon(Icons.add_task_rounded),
                  Flexible(
                    child: TextField(
                      autofocus: true, //自動フォーカス
                      maxLines: 1,
                      controller: taskController,
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: 'タスクの名前',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 70,
              ),
              Row(
                children: [
                  const Icon(Icons.today_rounded),
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
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 70,
              ),
              Row(
                children: [
                  const Icon(Icons.schedule_rounded),
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
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 8,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  if (taskValidation()) {
                    userRequest.postTask(
                      '${state.dateTime.year}.${state.dateTime.month}.${state.dateTime.day} ${state.timeOfDay.hour}:${state.timeOfDay.minute}',
                      taskController.text.trim(),
                    );
                  }
                },
                icon: const Icon(Icons.add_rounded),
                label: const Text('追加'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
