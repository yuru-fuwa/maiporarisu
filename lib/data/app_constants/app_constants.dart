import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static String baseUrl = '';
  static const String getTasks = '/gettasks';
  static const String postTask = '/create';
  static const String getTask = '/gettask';

  void init() {
    baseUrl = dotenv.env['BASE_URL'] ?? '';
  }
}
