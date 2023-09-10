import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maiporarisu/data/app_constants/app_constants.dart';
import 'package:maiporarisu/data/service/service.dart';

class DataController extends GetxController {
  DataService service = DataService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<dynamic> _myData = [];
  List<dynamic> get myData => _myData;
  Future<void> getData() async {
    _isLoading = true;
    Response response = await service.getData(AppConstants.getTasks);
    if (response.statusCode == 200) {
      _myData = response.body;
      debugPrint('we got the data');
      update();
    } else {
      debugPrint('we did not get any data');
    }
    _isLoading = false;
  }

  Future<void> postData(String time, String task) async {
    _isLoading = true;
    Response response = await service.postData(AppConstants.postTask, {
      'task_time': time,
      'task_name': task,
    });
    if (response.statusCode == 200) {
      update();
      debugPrint('data post successful');
    } else {
      debugPrint('data post failed');
    }
    _isLoading = false;
  }
}
