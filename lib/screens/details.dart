//
// detail.dart
// Netflix Clone
// 
// Author: wess (wess@appwrite.io)
// Created: 01/19/2022
// 
// Copywrite (c) 2022 Appwrite.io
//

import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:netflix_clone/providers/watchlist.dart';
import 'package:netflix_clone/widgets/buttons/icon.dart';
import 'package:netflix_clone/widgets/content/header.dart';
import 'package:provider/provider.dart';
import 'package:netflix_clone/data/entry.dart';
import 'package:netflix_clone/providers/entry.dart';


class DetailsScreen extends StatefulWidget {
  final Entry _entry;

  DetailsScreen({Key? key, required Entry entry}) : _entry = entry, super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
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
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _DetailHeader(featured: widget._entry),
          const SizedBox(height: 20,),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                widget._entry.description ?? "",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white
                )
              ),
            )
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                "Starring: ${widget._entry.cast}",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white
                )
              ),
            )
          ),
          const Spacer(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                VerticalIconButton(
                  icon: context.read<WatchListProvider>().isOnList(widget._entry) ? Icons.check : Icons.add, 
                  title: "My List", 
                  tap: () {
                    
                    if(context.read<WatchListProvider>().isOnList(widget._entry)){
                      context.read<WatchListProvider>().remove(widget._entry);
                    } else {
                      context.read<WatchListProvider>().add(widget._entry);
                    }
                    
                    Navigator.of(context).pop();
                  }
                ),
                const Spacer(),
                VerticalIconButton(
                  icon: Icons.thumb_up, 
                  title: "Rate", 
                  tap: () {}
                ),
                const Spacer(),
                VerticalIconButton(
                  icon: Icons.share, 
                  title: "Share", 
                  tap: () {}
                ),
                const Spacer(),
              ],
            )
          ),
          const Spacer(),
        ],
      )
    );
  }
}


class _DetailHeader extends StatelessWidget {
  final Entry featured;
  
  const _DetailHeader({Key? key, required this.featured}) : super(key: key);

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
          fit: StackFit.passthrough,
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
              child: BackdropFilter(                
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  height: 500,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6)
                  ),
                ),
              ),
            ),
                        Positioned(
              top: 1,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30,),
                onPressed: () => Navigator.of(context).pop(),
              )
            ),

            Positioned(
              bottom: 160,
              child: Container(
                height: 300,
                width: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.memory((snapshot.data! as Uint8List)).image,
                ),
              ),
              )
            ),
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
                        color: Colors.green
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      featured.releaseDate == null 
                      ? "2020"
                      : featured.netflixReleaseDate!.year.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Container(
                    color: Colors.black.withAlpha(180),
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      featured.ageRestriction == "AR13"
                      ? "13+"
                      : "18+",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      "${(featured.durationMinutes.inMinutes / 60).toStringAsFixed(2).replaceAll('.', 'h')}m",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  ),
                ],
              )
            ),

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
                    )
                  ),
                  MaterialButton(
                    color: Colors.white.withAlpha(40),
                    onPressed: () {}, 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.download, color: Colors.white,),
                        SizedBox(width: 8),
                        Text(
                          "Download",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        )
                      ],
                    )
                  ),
                ],
              )
            )
         ]
        );
      }
    );
  }
}