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
          ListTile(
            leading: const Icon(Icons.home_rounded),
            title: const Text(
              'ホーム',
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
