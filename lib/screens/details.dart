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

import 'package:flutter/material.dart';
import 'package:netflix_clone/providers/watchlist.dart';
import 'package:netflix_clone/widgets/buttons/icon.dart';
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
          const SizedBox(height: 20),
          FutureBuilder<Uint8List>(
            future: context.read<EntryProvider>().imageFor(widget._entry),
            builder: (context, snapshot) => snapshot.hasData && snapshot.data != null
                ? Container(
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: Image.memory(snapshot.data!).image,
                    ),
                  ),
                )
                : Container(),
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text(
                  widget._entry.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: VerticalIconButton(
                  icon: Icons.add, 
                  title: '',
                  tap: () {
                    context.read<WatchListProvider>().add(widget._entry);

                    Navigator.pop(context);
                  }
                ),
              )
            ],
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                widget._entry.description ?? "",
                style: const TextStyle(
                  color: Colors.white
                )
              ),
            )
          ),

          MaterialButton(
            color: Colors.blueGrey[500],
            child: const Text(
              'Close',
              style: TextStyle(
                color: Colors.white
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            }
          ),
          const SizedBox(height: 20),
        ],
      )
    );
  }
}
