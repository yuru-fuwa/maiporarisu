import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static String baseUrl = dotenv.env['VAR_NAME'] ?? "";
  static const String getTasks = "/gettasks";
  static const String postTask = "/create";
  static const String getTask = "/gettask";
}
