import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:maiporarisu/data/controllers/data_controller.dart';
import 'package:maiporarisu/ui/navigation/maiporarisu_navigation.dart';
import 'package:maiporarisu/ui/styles/color.dart';

void main() {
  runApp(const MaiporarisuApp());
}

class MaiporarisuApp extends StatelessWidget {
  const MaiporarisuApp({super.key});

  loadData() async {
    await Get.find<DataController>().getData();
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DataController());
    loadData();
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
        Locale("ja", "JP"),
      ],
      home: const MaiporarisuNavigation(),
    );
  }
}
