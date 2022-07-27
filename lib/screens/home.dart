//
// home.dart
// appflix
// 
// Author: wess (me@wess.io)
// Created: 01/03/2022
// 
// Copywrite (c) 2022 Wess.io
//

import 'package:netflix_clone/providers/entry.dart';
import 'package:netflix_clone/widgets/content/bar.dart';
import 'package:netflix_clone/widgets/content/header.dart';
import 'package:netflix_clone/widgets/content/list.dart';
import 'package:netflix_clone/widgets/previews.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class HomeScreen extends StatefulWidget {

 const  HomeScreen({required Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _scrollOffset = 0.0;
  ScrollController _scrollController =
      ScrollController(initialScrollOffset: 0.0);

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _scrollOffset = _scrollController.offset;
        });
      });

    
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 70.0),
        child: ContentBar(
          scrollOffset: _scrollOffset,
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: ContentHeader(featured: context.watch<EntryProvider>().featured),
          ),
          const SliverPadding(
            padding: EdgeInsets.only(top: 20),
            sliver: SliverToBoxAdapter(
              child: Previews(
                key: PageStorageKey('previews'),
                title: 'Previews',
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: ContentList(
                title: 'Only on Almost Netflix',
                contentList: context.watch<EntryProvider>().entries,
                isOriginal: false,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
              title: 'New releases',
              contentList: context.watch<EntryProvider>().originals,
              isOriginal: true,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 20),
            sliver: SliverToBoxAdapter(
              child: ContentList(
                title: 'Animation',
                contentList: context.watch<EntryProvider>().animations,
                isOriginal: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
