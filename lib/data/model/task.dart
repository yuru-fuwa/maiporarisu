import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
class Task with _$Task {
  const Task._();

  const factory Task({
    required String id,
    required String time,
    required String name,
    required bool check,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  DateTime get dateTime =>
      DateFormat("yyyy-MM-dd'T'HH:mm:ssZ").parse(time).toLocal();

  static Task get mockTask => const Task(
        id: '1',
        time: '2023-09-01T12:00:00+09:00',
        name: 'test',
        check: false,
      );

  static List<Task> get mockTasks => [
        const Task(
          id: '1',
          time: '2023-09-01T12:00:00+09:00',
          name: '市役所',
          check: true,
        ),
        const Task(
          id: '2',
          time: '2023-10-08T15:00:00+09:00',
          name: '買い物',
          check: false,
        ),
        const Task(
          id: '3',
          time: '2023-10-14T11:00:00+09:00',
          name: '昼食',
          check: false,
        ),
        const Task(
          id: '4',
          time: '2023-10-14T18:30:00+09:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '5',
          time: '2023-10-14T08:30:00+09:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '6',
          time: '2023-11-04T10:00:00+09:00',
          name: 'test',
          check: true,
        ),
        const Task(
          id: '7',
          time: '2023-11-04T12:30:00+09:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '8',
          time: '2023-11-11T09:30:00+09:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '9',
          time: '2023-11-11T10:15:00+09:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '10',
          time: '2023-11-11T14:30:00+09:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '11',
          time: '2023-11-11T15:30:00+09:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '12',
          time: '2023-11-11T16:00:00+09:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '13',
          time: '2023-11-11T17:00:00+09:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '14',
          time: '2023-11-11T18:30:00+09:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '15',
          time: '2023-08-11T19:30:00+09:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '16',
          time: '2023-11-11T20:00:00+09:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '17',
          time: '2023-11-30T20:30:00+09:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '18',
          time: '2023-11-11T21:30:00+09:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '19',
          time: '2023-11-10T22:00:00+09:00',
          name: 'test',
          check: false,
        ),
        const Task(
          id: '20',
          time: '2023-11-30T22:30:00+09:00',
          name: 'test',
          check: false,
        ),
      ];
}
