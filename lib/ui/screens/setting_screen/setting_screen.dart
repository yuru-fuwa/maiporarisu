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
          return SettingListItem(
            title: items[index]['title']!,
            subtitle: items[index]['text']!,
          );
        },
      ),
    );
  }
}

class SettingListItem extends StatelessWidget {
  final String title;
  final String subtitle;

  SettingListItem({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      child: ListTile(
        leading: const Icon(Icons.add_alert),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
