//
// main.dart
// appflix
//
// Author: wess (me@wess.io)
// Created: 12/29/2021
//
// Copywrite (c) 2022 Wess.io
//

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/constants.dart';
import '/providers/account.dart';
import '/providers/movies.dart';
import '/providers/watchlist.dart';
import '/screens/navigation.dart';
import '/screens/onboarding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (AppwriteConstants.selfSigned) {
    debugNetworkImageHttpClientProvider = () => HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AccountProvider()),
      ChangeNotifierProvider(create: (context) => MoviesProvider()),
      ChangeNotifierProvider(create: (context) => WatchListProvider()),
    ],
    child: const Main(),
  ));
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    context.read<AccountProvider>().isValid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AccountProvider>();
    return MaterialApp(
      title: 'Appflix',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: user.session == null ? const OnboardingScreen() : const NavScreen(),
    );
  }
}
