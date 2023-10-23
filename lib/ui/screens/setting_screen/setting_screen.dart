import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        'title': '設定1',
        'text': '設定1の説明',
        'icon': Icons.add_alert,
      },
      {
        'title': '設定2',
        'text': '設定2の説明',
        'icon': Icons.people,
      },
      {
        'title': '設定3',
        'text': '設定3の説明',
        'icon': Icons.delete_forever,
      },
    ];

    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return SettingListItem(
            title: items[index]['title'],
            text: items[index]['text'],
            icon: items[index]['icon'],
          );
        },
      ),
    );
  }
}

class SettingListItem extends StatelessWidget {
  final String title;
  final String text;
  final IconData icon;

  const SettingListItem({
    Key? key,
    required this.title,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
