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
import 'package:provider/provider.dart';

import '/providers/movies.dart';
import '/screens/home.dart';
import '/screens/watchlist.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  Widget home() => const HomeScreen(key: PageStorageKey('homescreen'));

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<MoviesProvider>().list(),
      builder: (context, snapshot) {
        return Scaffold(
          body: home(),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            unselectedItemColor: Colors.white,
            currentIndex: 0,
            onTap: (index) async {
              if (index == 1) {
                await showDialog(
                    context: context,
                    builder: (context) => const WatchlistScreen());
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Watchlist',
              ),
            ],
          ),
        );
      },
    );
  }
}
