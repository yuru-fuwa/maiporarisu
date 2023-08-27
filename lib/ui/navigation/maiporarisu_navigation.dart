import 'package:flutter/material.dart';

class MaiporarisuNavigation extends StatefulWidget {
  const MaiporarisuNavigation({super.key});

  @override
  State<MaiporarisuNavigation> createState() => _MaiporarisuNavigationState();
}

class _MaiporarisuNavigationState extends State<MaiporarisuNavigation> {
  var _currentPageIndex = 0;
  
  final _pages = <Widget>[
    Container(
      alignment: Alignment.center,
      child: const Text('Home'),
    ),
    Container(
      alignment: Alignment.center,
      child: const Text('Schedule'),
    ),
    Container(
      alignment: Alignment.center,
      child: const Text('Setting'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
