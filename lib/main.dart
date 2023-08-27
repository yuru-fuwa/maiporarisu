import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:maiporarisu/ui/navigation/maiporarisu_navigation.dart';
import 'package:maiporarisu/ui/styles/color.dart';

void main() {
  runApp(const MaiporarisuApp());
}

class MaiporarisuApp extends StatelessWidget {
  const MaiporarisuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maiporarisu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MaiporarisuColor.keyColor),
        useMaterial3: true,
      ),
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
