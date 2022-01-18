//
// entry.dart
// appflix
// 
// Author: wess (me@wess.io)
// Created: 01/03/2022
// 
// Copywrite (c) 2022 Wess.io
//

import 'dart:async';
import 'dart:typed_data';

import 'package:netflix_clone/api/client.dart';
import 'package:netflix_clone/data/entry.dart';
import 'package:flutter/material.dart';

class EntryProvider extends ChangeNotifier {
  
  static String _collectionId = "movies";

  Entry _featured = Entry.empty();
  Entry get featured => _featured;

  List<Entry> _entries = [];
  List<Entry> get entries => _entries;

  List<Entry> get originals => _entries.where((entry) => entry.isOriginal).toList();

  List<Entry> get trending {
    var trending = _entries;

    trending.sort((a, b) => b.trendingIndex.compareTo(a.trendingIndex));

    return trending;
  }

  Future<void> list() async {
    var result = await ApiClient.database.listDocuments(collectionId: _collectionId);

    _entries = result.documents.map((document) => Entry.fromJson(document.data)).toList();
    _featured = _entries.isEmpty ? Entry.empty() : _entries[0];

    notifyListeners();
  }

  Future<Uint8List> imageFor(Entry entry) async {
    return await ApiClient.storage.getFileView(fileId: entry.thumbnailImageId);
  }
}