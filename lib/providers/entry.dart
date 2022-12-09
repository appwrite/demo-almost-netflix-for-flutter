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
  final Map<String, Uint8List> _imageCache = {};

  static const String _databaseId = "default";
  static const String _collectionId = "movies";
  static const String _bucketId = "default";

  Entry? _selected;
  Entry? get selected => _selected;

  Entry _featured = Entry.empty();
  Entry get featured => _featured;

  List<Entry> _entries = [];
  List<Entry> get entries => _entries;
  List<Entry> get originals => _entries.where((e) => e.isOriginal).toList();
  List<Entry> get animations => _entries
      .where((e) => e.genres.contains('animation'))
      .toList();
  List<Entry> get newReleases => _entries
      .where((e) =>
          e.releaseDate != null &&
          e.releaseDate!.isAfter(DateTime.parse('2018-01-01')))
      .toList();

  List<Entry> get trending {
    var trending = _entries;

    trending.sort((a, b) => b.trendingIndex.compareTo(a.trendingIndex));

    return trending;
  }

  void setSelected(Entry entry) {
    _selected = entry;

    notifyListeners();
  }

  Future<void> list() async {
    var result =
        await ApiClient.database.listDocuments(databaseId: _databaseId, collectionId: _collectionId);

    _entries = result.documents
        .map((document) => Entry.fromJson(document.data))
        .toList();
    _featured = _entries.isEmpty ? Entry.empty() : _entries[0];

    notifyListeners();
  }

  Future<Uint8List> imageFor(Entry entry) async {
    if (_imageCache.containsKey(entry.thumbnailImageId)) {
      return _imageCache[entry.thumbnailImageId]!;
    }

    final result = await ApiClient.storage.getFileView(
      bucketId: _bucketId,
      fileId: entry.thumbnailImageId,
    );

    _imageCache[entry.thumbnailImageId] = result;

    return result;
  }
}
