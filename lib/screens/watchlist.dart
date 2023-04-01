//
// watchlist.dart
// Netflix Clone
//
// Author: wess (wess@appwrite.io)
// Created: 01/19/2022
//
// Copywrite (c) 2022 Appwrite.io
//

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/data/watchlist.dart';
import '/providers/watchlist.dart';
import '/screens/details.dart';
import '/widgets/buttons/icon.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({Key? key}) : super(key: key);

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _row(Watchlist w) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            image: w.movie.thumbnailImageUrl.isEmpty
                ? null
                : DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage(w.movie.thumbnailImageUrl),
                  ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              w.movie.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              ((w.movie.description ?? "").length < 51)
                  ? (w.movie.description ?? "")
                  : "${(w.movie.description ?? "").substring(0, 50)}...",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        )),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 30, 20),
          child: VerticalIconButton(
            icon: Icons.delete,
            title: '',
            tap: () async {
              await context.read<WatchListProvider>().remove(w);
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final watchlists = context.watch<WatchListProvider>().watchlists;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Watchlist'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ListView(
        children: watchlists.entries
            .map(
              (entry) => GestureDetector(
                child: _row(entry.value),
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) =>
                        DetailsScreen(movie: entry.value.movie),
                  );
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
