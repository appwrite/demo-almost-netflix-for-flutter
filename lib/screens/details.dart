//
// detail.dart
// Netflix Clone
//
// Author: wess (wess@appwrite.io)
// Created: 01/19/2022
//
// Copywrite (c) 2022 Appwrite.io
//

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/watchlist.dart';
import '/widgets/buttons/icon.dart';
import '../data/movie.dart';

class DetailsScreen extends StatefulWidget {
  final Movie _movie;

  const DetailsScreen({
    Key? key,
    required Movie movie,
  })  : _movie = movie,
        super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final watchListProvider = context.watch<WatchListProvider>();
    final watchlist = watchListProvider.watchlists[widget._movie.id];
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _DetailHeader(featured: widget._movie),
        const SizedBox(
          height: 20,
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Text(widget._movie.description ?? "",
              style: const TextStyle(fontSize: 14, color: Colors.white)),
        )),
        const SizedBox(height: 20),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Text("Starring: ${widget._movie.cast.join(", ")}",
              style: const TextStyle(fontSize: 12, color: Colors.white)),
        )),
        const Spacer(),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            VerticalIconButton(
                icon: watchlist != null ? Icons.check : Icons.add,
                title: "My List",
                tap: () {
                  if (watchlist != null) {
                    context.read<WatchListProvider>().remove(watchlist);
                  } else {
                    context.read<WatchListProvider>().add(widget._movie);
                  }
                }),
            const Spacer(),
            VerticalIconButton(icon: Icons.thumb_up, title: "Rate", tap: () {}),
            const Spacer(),
            VerticalIconButton(icon: Icons.share, title: "Share", tap: () {}),
            const Spacer(),
          ],
        )),
        const Spacer(),
      ],
    ));
  }
}

class _DetailHeader extends StatelessWidget {
  final Movie featured;

  const _DetailHeader({Key? key, required this.featured}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.center,
        children: [
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
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                height: 500,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.6)),
              ),
            ),
          ),
          Positioned(
              top: 1,
              left: 10,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () => Navigator.of(context).pop(),
              )),
          Positioned(
              bottom: 160,
              child: Container(
                height: 300,
                width: 200,
                decoration: BoxDecoration(
                  image: featured.thumbnailImageUrl.isEmpty
                      ? null
                      : DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(featured.thumbnailImageUrl),
                        ),
                ),
              )),
          Positioned(
              bottom: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "96% Match",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      featured.releaseDate == null
                          ? "2020"
                          : featured.netflixReleaseDate!.year.toString(),
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    color: Colors.black.withAlpha(180),
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      featured.ageRestriction == "AR13" ? "13+" : "18+",
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      "${(featured.durationMinutes.inMinutes / 60).floor().toStringAsFixed(2).replaceAll('.', 'h')}m",
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              )),
          Positioned(
              bottom: 10,
              right: 10,
              left: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                      color: Colors.white,
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.play_arrow),
                          SizedBox(width: 8),
                          Text("Play")
                        ],
                      )),
                  MaterialButton(
                      color: Colors.white.withAlpha(40),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.download,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Download",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )),
                ],
              ))
        ]);
  }
}
