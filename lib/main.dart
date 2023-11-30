import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maiporarisu/data/service/user_request.dart';
import 'package:maiporarisu/ui/screens/schedule_map_screen/map_schedule_screen.dart';
import 'package:maiporarisu/ui/styles/color.dart';

Future<void> main() async {
  await dotenv.load();
  AppConstants().init();
  runApp(
    const ProviderScope(
      child: MaiporarisuApp(),
    ),
  );
}

class MaiporarisuApp extends StatelessWidget {
  const MaiporarisuApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
      ),
    );
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );

    return MaterialApp(
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
      home: const MapScheduleScreen(),
    );
  }
}
