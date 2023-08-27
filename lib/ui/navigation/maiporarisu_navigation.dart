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
        elevation: 10,
        height: 100,
	labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const <Widget>[
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'ホーム',
              selectedIcon: Icon(Icons.home_rounded),
              ),
          NavigationDestination(
              icon: Icon(Icons.today_outlined),
              label: 'スケジュール',
              selectedIcon: Icon(Icons.today_rounded),
              ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: '設定',
            selectedIcon: Icon(Icons.settings_rounded),
          ),
        ],
      ),
      body: _pages[_currentPageIndex],
    );
  }
}
