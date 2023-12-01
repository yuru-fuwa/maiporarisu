import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maiporarisu/data/model/task.dart';
import 'package:maiporarisu/data/service/service_constants.dart';

class UserRequest {
  UserRequest({
    this.isMock = false,
  });

  final bool isMock;

  final Uri _taskUrl = Uri.parse(AppConstants.taskUrl);

  Future<List<Task>> getAllTasks() async {
    if (isMock) {
      return Task.mockTasks;
    }

    http.Response response = await http.get(
      _taskUrl,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      debugPrint('get no data');
      return <Task>[];
    }
    List taskMap = jsonDecode(utf8.decode(response.bodyBytes));
    List<Task> tasks = [];
    for (var task in taskMap) {
      tasks.add(Task.fromJson(task));
    }

    return tasks;
  }

  Future<void> postTask(String time, String name) async {
    http.Response response = await http.post(
      _taskUrl,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          'time': time,
          'name': name,
        },
      ),
    );
    debugPrint(_taskUrl.toString());
    if (response.statusCode == 200) {
      debugPrint('data post successful');
    } else {
      debugPrint('data post failed');
    }
  }

  Future<void> deleteTask(int taskId) async {
    Uri deleteUrl = Uri.parse('${_taskUrl.toString()}/$taskId');

    http.Response response = await http.delete(
      deleteUrl,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      debugPrint('Task deleted successfully');
    } else {
      debugPrint('Task deletion failed');
    }
  }

  Future<void> updateTask(int taskId, String time, String name) async {
    Uri updateUrl = Uri.parse('${_taskUrl.toString()}/$taskId');

    http.Response response = await http.put(
      updateUrl,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          'time': time,
          'name': name,
        },
      ),
    );

    if (response.statusCode == 200) {
      debugPrint('Task updated successfully');
    } else {
      debugPrint('Task update failed');
    }
  }
}
