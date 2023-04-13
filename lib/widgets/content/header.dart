//
// header.dart
// appflix
//
// Author: wess (me@wess.io)
// Created: 01/03/2022
//
// Copywrite (c) 2022 Wess.io
//

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/data/movie.dart';
import '/providers/watchlist.dart';
import '/screens/details.dart';
import '/widgets/buttons/icon.dart';

class ContentHeader extends StatelessWidget {
  final Movie featured;

  const ContentHeader({Key? key, required this.featured}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final watchListProvider = context.watch<WatchListProvider>();
    final watchlist = watchListProvider.watchlists[featured.id];
    return Stack(alignment: Alignment.center, children: [
      Container(
        height: 500,
        decoration: BoxDecoration(
          image: featured.thumbnailImageUrl.isEmpty
              ? null
              : DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(featured.thumbnailImageUrl),
                ),
        ),
      ),
      Container(
        height: 500,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ),
      Positioned(
        bottom: 120,
        child: SizedBox(
            width: 250,
            child: Text(
              featured.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            )),
      ),
      Positioned(
        bottom: 88,
        child: SizedBox(
            width: 250,
            child: Text(
              featured.tags.join(" • "),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.normal,
              ),
            )),
      ),
      Positioned(
        right: 0,
        left: 0,
        bottom: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Spacer(),
            VerticalIconButton(
              icon: watchlist != null ? Icons.check : Icons.add,
              title: 'Watchlist',
              tap: () {
                if (watchlist != null) {
                  watchListProvider.remove(watchlist);
                } else {
                  watchListProvider.add(featured);
                }
              },
            ),
            const SizedBox(width: 40),
            MaterialButton(
                color: Colors.white,
                child: Row(
                  children: const [Icon(Icons.play_arrow), Text("Play")],
                ),
                onPressed: () {}),
            const SizedBox(width: 40),
            VerticalIconButton(
              icon: Icons.info,
              title: 'Info',
              tap: () async {
                await showDialog(
                    context: context,
                    builder: (context) => DetailsScreen(movie: featured));
              },
            ),
            const Spacer(),
          ],
        ),
      )
    ]);
  }
}
