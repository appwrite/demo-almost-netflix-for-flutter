//
// list.dart
// appflix
//
// Author: wess (me@wess.io)
// Created: 01/03/2022
//
// Copywrite (c) 2022 Wess.io
//

import 'package:flutter/material.dart';

import '/data/movie.dart';
import '/screens/details.dart';

class ContentList extends StatelessWidget {
  final String title;
  final List<Movie> contentList;
  final bool isOriginal;

  const ContentList({
    Key? key,
    required this.title,
    required this.contentList,
    required this.isOriginal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30.0, bottom: 10, top: 20),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: contentList.length,
            itemBuilder: (context, int count) {
              final current = contentList[count];
              return GestureDetector(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => DetailsScreen(movie: current),
                  );
                },
                child: Container(
                  height: 100,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 4,
                  ),
                  child: current.thumbnailImageUrl.isEmpty
                      ? null
                      : Image(
                          image: NetworkImage(current.thumbnailImageUrl),
                          fit: BoxFit.cover,
                        ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
