import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> items = [
      {
        'title': '設定1',
        'text': '設定1の説明',
      },
      {
        'title': '設定2',
        'text': '設定2の説明',
      },
      {
        'title': '設定2',
        'text': '設定2の説明',
      },
    ];

    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]['title']!),
            subtitle: Text(items[index]['text']!),
          );
        },
      ),
    );
  }
}
