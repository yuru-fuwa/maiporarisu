import 'package:flutter/material.dart';
import 'package:maiporarisu/ui/screens/home_screen/home_screen.dart';
import 'package:maiporarisu/ui/screens/schedule_screen/schedule_screen.dart';
import 'package:maiporarisu/ui/screens/setting_screen/setting_screen.dart';

class MaiporarisuNavigation extends StatefulWidget {
  const MaiporarisuNavigation({super.key});

  @override
  State<MaiporarisuNavigation> createState() => _MaiporarisuNavigationState();
}

class _MaiporarisuNavigationState extends State<MaiporarisuNavigation> {
  var _currentPageIndex = 0;

  final _pages = <Widget>[
    const HomeScreen(),
    const ScheduleScreen(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('まいぽらりす'),
        centerTitle: true,
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        selectedIndex: _currentPageIndex,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'ホーム',
          ),
          NavigationDestination(
            icon: Icon(Icons.today_outlined),
            selectedIcon: Icon(Icons.today_rounded),
            label: 'スケジュール',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings_rounded),
            label: '設定',
          ),
        ],
      ),
      body: _pages[_currentPageIndex],
    );
  }
}
