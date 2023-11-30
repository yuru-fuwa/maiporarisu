import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static String taskUrl = '';

  void init() {
    taskUrl = dotenv.env['BASE_URL'] ?? '';
  }
}