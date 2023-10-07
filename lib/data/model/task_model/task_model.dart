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
        time: '2021-09-01 12:00:00',
        name: 'test',
        check: false,
      );
}
