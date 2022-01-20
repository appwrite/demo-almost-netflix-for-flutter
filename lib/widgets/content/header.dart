//
// header.dart
// appflix
// 
// Author: wess (me@wess.io)
// Created: 01/03/2022
// 
// Copywrite (c) 2022 Wess.io
//

import 'dart:typed_data';

import 'package:netflix_clone/data/entry.dart';
import 'package:netflix_clone/providers/entry.dart';
import 'package:netflix_clone/providers/watchlist.dart';
import 'package:netflix_clone/screens/details.dart';
import 'package:netflix_clone/widgets/buttons/icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';

class ContentHeader extends StatelessWidget {
  final Entry featured;
  
  const ContentHeader({Key? key, required this.featured}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
      future: context.read<EntryProvider>().imageFor(featured),
      builder: (context, snapshot) {
        if(snapshot.hasData == false || snapshot.data == null) {
          return const SizedBox(
            height: 500,
            child: Center(child: CircularProgressIndicator(),),
          );
        }

        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 500,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.memory((snapshot.data! as Uint8List)).image,
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
                )
              ),
            ),
            Positioned(
              bottom: 88,
              child: SizedBox(
                width: 250,
                child: Text(
                  featured.tags.replaceAll(", ", " • "),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                  ),
                )
              ),
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
                    icon: context.read<WatchListProvider>().isOnList(featured) ? Icons.check : Icons.add,
                    title: 'Watchlist',
                    tap: () {
                      if(context.read<WatchListProvider>().isOnList(featured)){
                        context.read<WatchListProvider>().remove(featured);
                      } else {
                        context.read<WatchListProvider>().add(featured);
                      }
                    },
                  ),

                  const SizedBox(width: 40),

                  MaterialButton(
                    color: Colors.white,
                    child: Row(
                      children: const [
                        Icon(Icons.play_arrow),
                        Text("Play")
                      ],
                    ),
                    onPressed: (){}
                  ),

                  const SizedBox(width: 40),

                  VerticalIconButton(
                    icon: Icons.info,
                    title: 'Info',
                    tap: () async {
                      await showDialog(
                        context: context, 
                        builder: (context) => DetailsScreen(entry: featured)
                      );
                    },
                  ),
                  const Spacer(),
                ],
              ),
            )
          ]
        );
      }
    );
  }
}