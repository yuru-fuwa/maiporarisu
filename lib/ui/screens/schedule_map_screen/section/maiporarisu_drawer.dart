import 'package:flutter/material.dart';
import 'package:maiporarisu/ui/screens/home_screen/home_screen.dart';
import 'package:maiporarisu/ui/screens/setting_screen/setting_screen.dart';

class MaiporarisuDrawer extends StatelessWidget {
  const MaiporarisuDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.menu_open_rounded),
                padding: const EdgeInsets.all(16),
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'まいぽらりす',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(width: 56),
            ],
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.list_alt),
            title: const Text(
              'タスク一覧',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_rounded),
            title: const Text(
              '設定',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
