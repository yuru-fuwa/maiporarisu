import 'package:flutter/material.dart';
import 'package:maiporarisu/ui/screens/schedule_map_screen/map_schedule_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        // 'title': 'ペアリング',
        // 'text': 'QRコードを読み取りタスクを共有します',
        'title': '設定',
        'text': 'アプリの設定を変更します',
        'icon': Icons.settings_rounded,
        'route': const MapScheduleScreen(),
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
            route: items[index]['route'],
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
  final Widget route;

  const SettingListItem({
    super.key,
    required this.title,
    required this.text,
    required this.icon,
    required this.route,
  });

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
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => route,
            ),
          );
        },
      ),
    );
  }
}
