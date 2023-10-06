import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:maiporarisu/data/app_constants/app_constants.dart';
import 'package:maiporarisu/ui/navigation/maiporarisu_navigation.dart';
import 'package:maiporarisu/ui/styles/color.dart';

Future<void> main() async {
  await dotenv.load();
  AppConstants().init();
  runApp(const MaiporarisuApp());
}

class MaiporarisuApp extends StatelessWidget {
  const MaiporarisuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Maiporarisu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: MaiporarisuColor.keyColor,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: MaiporarisuColor.keyColor,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja', 'JP'),
      ],
      home: const MaiporarisuNavigation(),
    );
  }
}
