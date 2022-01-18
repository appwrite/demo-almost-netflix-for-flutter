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
import 'package:netflix_clone/data/entry.dart';

class ContentList extends StatelessWidget {
  final String title;
  final List<Entry> contentList;
  bool isOriginal;
  ContentList(
      {Key? key,
      required this.title,
      required this.contentList,
      required this.isOriginal})
      : super(key: key);

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
              fontSize: 20.0
            ),
          ),
        ),
        Container(
          height: isOriginal ? 500 : 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: contentList.length,
            itemBuilder: (context, int count) {
              final Entry current = contentList[count];
              return GestureDetector(
                onTap: () {
                  print(current.name);
                },
                child: Container(
                  height: isOriginal ? 400 : 200,
                  width: isOriginal ? 250 : 170,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  // decoration: BoxDecoration(
                  //   image: DecorationImage(
                  //       image: AssetImage(current.thumbnailImageId), fit: BoxFit.cover),
                  // ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
