//
// previews.dart
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
import '/providers/movies.dart';
import '/screens/details.dart';

class Previews extends StatefulWidget {
  final String title;

  const Previews({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<Previews> createState() => _PreviewsState();
}

class _PreviewsState extends State<Previews> {
  Widget _renderStack(Movie movie) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          height: 130,
          width: 130,
          decoration: BoxDecoration(
            image: movie.thumbnailImageUrl.isEmpty
                ? null
                : DecorationImage(
                    image: NetworkImage(movie.thumbnailImageUrl),
                    fit: BoxFit.cover,
                  ),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withAlpha(40),
              width: 4.0,
            ),
          ),
        ),
        Container(
          height: 130,
          width: 130,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.black87, Colors.black45, Colors.transparent],
              stops: [0, 0.25, 1],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withAlpha(40),
              width: 4.0,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: SizedBox(
            height: 60,
            child: Text(
              movie.name.length > 14 ? movie.name.substring(0, 14) : movie.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var movies = context.watch<MoviesProvider>().movies;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 30.0),
          child: Text(
            'Popular this week',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
        ),
        SizedBox(
          height: 165.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (BuildContext context, int index) {
              final Movie movie = movies[index];

              return GestureDetector(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => DetailsScreen(movie: movie),
                  );
                },
                child: _renderStack(movie),
              );
            },
          ),
        ),
      ],
    );
  }
}
