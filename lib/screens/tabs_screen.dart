import 'package:flutter/material.dart';

import './first_screen.dart';
import './second_screen.dart';
import './settings_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

var currentIndex = 0;

final screens = [
  FirstScreen(),
  SecondScreen(),
  SettingsScreen(),
];

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: TabBar(
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            indicatorColor: Colors.red,
            tabs: [
              Tab(
                text: '1',
              ),
              Tab(
                text: '2',
              ),
              Tab(
                text: 'USTAWIENIA',
              )
            ],
          ),
        ),
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
      ),
    );
  }
}
