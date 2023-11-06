import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required String id,
    required String time,
    required String name,
    required bool check,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  static Task get mockTask => const Task(
        id: '1',
        time: '2023-09-01 12:00:00',
        name: 'test',
        check: false,
      );

  static List<Task> get mockTasks => [
        const Task(
          id: '1',
          time: '2023-09-01 12:00:00',
          name: '市役所',
          check: true,
        ),
        const Task(
          id: '2',
          time: '2023-10-08 15:00:00',
          name: '買い物',
          check: false,
        ),
        const Task(
          id: '3',
          time: '2023-10-14 11:00:00',
          name: '昼食',
          check: false,
        ),
        const Task(
          id: '4',
          time: '2023-10-14 18:30:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '5',
          time: '2023-10-14 08:30:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '6',
          time: '2023-11-04 10:00:00',
          name: 'test',
          check: true,
        ),
        const Task(
          id: '7',
          time: '2023-11-04 12:30:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '8',
          time: '2023-11-11 09:30:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '9',
          time: '2023-11-11 10:15:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '10',
          time: '2023-11-11 14:30:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '11',
          time: '2023-11-11 15:30:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '12',
          time: '2023-11-11 16:30:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '13',
          time: '2023-11-11 17:00:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '14',
          time: '2023-11-11 18:30:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '15',
          time: '2023-11-11 19:00:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '16',
          time: '2023-11-11 20:00:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '17',
          time: '2023-11-11 20:30:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '18',
          time: '2023-11-11 21:30:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '19',
          time: '2023-11-11 22:00:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '20',
          time: '2023-11-11 22:30:00',
          name: 'test',
          check: false,
        ),
      ];
}
