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
import 'package:netflix_clone/widgets/buttons/icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _PlayButton extends StatelessWidget {
  const _PlayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.white,
      onPressed: () {
        print('play');
      },
      child: Row(
        children: const [
          Icon(
            Icons.play_arrow,
            size: 30,
          ),
          Text(
            'Play',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}


class ContentHeader extends StatelessWidget {
  final Entry featured;
  
  const ContentHeader({Key? key, required this.featured}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
      future: context.read<EntryProvider>().imageFor(featured),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
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
              bottom: 110,
              child: SizedBox(
                width: 250,
                child: Image.memory((snapshot.data! as Uint8List)),
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  VerticalIconButton(
                    icon: Icons.add,
                    title: 'List',
                    tap: () => print('list'),
                  ),
                const _PlayButton(),
                  VerticalIconButton(
                    icon: Icons.info,
                    title: 'Info',
                    tap: () => print('list'),
                  )
                ],
              ),
            )
          ]
        );
      }
    );
  }
}