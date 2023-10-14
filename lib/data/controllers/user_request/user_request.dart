import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maiporarisu/data/app_constants/app_constants.dart';
import 'package:maiporarisu/data/model/task_model/task_model.dart';

class UserRequest {
  UserRequest({
    this.isMock = false,
  });

  final bool isMock;

  final Uri _getTasksUrl = Uri.parse(AppConstants.getTasksUrl);
  final Uri _postTaskUrl = Uri.parse(AppConstants.postTaskUrl);

  Future<List<Task>> getAllTasks() async {
    if (isMock) {
      return <Task>[Task.mockTask];
    }

    http.Response response = await http.get(
      _getTasksUrl,
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
      _postTaskUrl,
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
    debugPrint(_postTaskUrl.toString());
    if (response.statusCode == 200) {
      debugPrint('data post successful');
    } else {
      debugPrint('data post failed');
    }
  }
}
