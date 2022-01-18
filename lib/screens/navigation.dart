//
// navigation.dart
// appflix
// 
// Author: wess (me@wess.io)
// Created: 01/03/2022
// 
// Copywrite (c) 2022 Wess.io
//

import 'package:flutter/material.dart';
import 'package:netflix_clone/Screens/home.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [
    const HomeScreen(key: PageStorageKey('homescreen')),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];

  final Map<String, IconData> _icons = {
    'Home': Icons.home,
    'Search': Icons.search,
    'Coming Soon': Icons.queue_play_next,
    'Downloads': Icons.download,
    'More': Icons.menu
  };

  int _currentIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: _icons
          .map(
            (title, icon) => MapEntry(
              title,
              BottomNavigationBarItem(
                icon: Icon(
                  icon,
                  size: 30,
                ),
                label: title,
              ),
            ),
          )
          .values
          .toList(),
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 11.0,
        unselectedFontSize: 11.0,
        onTap: (value) => setState(() => _currentIndex = value),
      )
    );
  }
}
