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

  static get mockTask => const Task(
        id: '1',
        time: '2023-09-01 12:00:00',
        name: 'test',
        check: false,
      );

  static get mockTasks => [
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
      ];
}
