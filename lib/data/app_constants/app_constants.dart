import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static String baseUrl = '';
  static const String getTasks = '/gettasks';
  static const String getTask = '/gettask';
  static const String postTask = '/create';

  static String get getTasksUrl => baseUrl + getTasks;
  static String get getTaskUrl => baseUrl + getTask;
  static String get postTaskUrl => baseUrl + postTask;

  void init() {
    baseUrl = dotenv.env['BASE_URL'] ?? '';
  }
}
