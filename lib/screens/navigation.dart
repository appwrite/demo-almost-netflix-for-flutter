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
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:netflix_clone/data/entry.dart';
import 'package:netflix_clone/screens/watchlist.dart';
import 'package:provider/provider.dart';
import 'package:netflix_clone/providers/entry.dart';
import 'package:netflix_clone/Screens/home.dart';


class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {

  Widget home() => const HomeScreen(key: PageStorageKey('homescreen'));

  @override
  Widget build(BuildContext context) {
    Entry? selected = context.watch<EntryProvider>().selected;

    return FutureBuilder(
      future: context.read<EntryProvider>().list(),
      builder: (context, snapshot) {
        return Scaffold(
          body: home(),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            unselectedItemColor: Colors.white,
            currentIndex: 0,
            onTap: (index) async {
              if(index == 1) {
                await showDialog(
                  context: context, 
                  builder: (context) => const WatchlistScreen()
                );

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
      }
    );
  }
}
