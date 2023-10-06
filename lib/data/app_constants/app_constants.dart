import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static String baseUrl = '';
  static const String getTasks = '/gettasks';
  static const String getTask = '/gettask';
  static const String postTask = '/create';

  get getTasksUrl => baseUrl + getTasks;
  get getTaskUrl => baseUrl + getTask;
  get postTaskUrl => baseUrl + postTask;

  void init() {
    baseUrl = dotenv.env['BASE_URL'] ?? '';
  }
}
