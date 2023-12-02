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

    Uri getTaskUrl =
        Uri.parse('${AppConstants.taskUrl}/${AppConstants.testUser}');

    http.Response response = await http.get(
      getTaskUrl,
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
          'user_id': AppConstants.testUser,
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

  Future<void> updateTask(
    String id,
    String userId,
    String time,
    String name,
    bool check,
  ) async {
    Uri updateUrl = Uri.parse('${AppConstants.taskUrl}/$id');

    http.Response response = await http.put(
      updateUrl,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          'user_id': userId,
          'time': time,
          'name': name,
          'check': check,
        },
      ),
    );

    debugPrint(updateUrl.toString());

    if (response.statusCode == 200) {
      debugPrint('data update successful');
    } else {
      debugPrint('data update failed');
    }
  }

  Future<void> deleteTask(String id) async {
    Uri deleteUrl = _taskUrl.replace(path: '${_taskUrl.path}/$id');

    http.Response response = await http.delete(
      deleteUrl,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    debugPrint(deleteUrl.toString());

    if (response.statusCode == 200) {
      debugPrint('data deletion successful');
    } else {
      debugPrint('data deletion failed');
    }
  }
}
