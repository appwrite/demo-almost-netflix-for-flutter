//
// watchlist.dart
// Netflix Clone
//
// Author: wess (wess@appwrite.io)
// Created: 01/19/2022
//
// Copywrite (c) 2022 Appwrite.io
//

import 'dart:collection';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';

import '/api/client.dart';
import '/constants.dart';
import '/data/movie.dart';
import '/data/watchlist.dart';

class WatchListProvider extends ChangeNotifier {
  final String _databaseId = ID.custom(AppwriteConstants.databaseId);
  final String _collectionId = ID.custom(
    AppwriteConstants.watchlistCollectionId,
  );

  final Map<String, Watchlist> _watchlists = {};
  UnmodifiableMapView<String, Watchlist> get watchlists =>
      UnmodifiableMapView(_watchlists);

  Future<User> get user {
    return ApiClient.account.get();
  }

  Future<UnmodifiableMapView<String, Watchlist>> list() async {
    final user = await this.user;

    final documentList = await ApiClient.database.listDocuments(
      databaseId: _databaseId,
      collectionId: _collectionId,
      queries: [
        Query.equal("userId", user.$id),
      ],
    );

    _watchlists.clear();

    for (final document in documentList.documents) {
      final watchlist = Watchlist.fromJson(document.data);
      _watchlists[watchlist.movie.id] = watchlist;
    }

    notifyListeners();

    return watchlists;
  }

  Future<void> add(Movie movie) async {
    final user = await this.user;

    await ApiClient.database.createDocument(
      databaseId: _databaseId,
      collectionId: _collectionId,
      documentId: ID.unique(),
      data: {
        "userId": user.$id,
        "movie": movie.id,
      },
    );

    list();
  }

  Future<void> remove(Watchlist watchlist) async {
    await ApiClient.database.deleteDocument(
      databaseId: _databaseId,
      collectionId: _collectionId,
      documentId: watchlist.id,
    );

    list();
  }
}
