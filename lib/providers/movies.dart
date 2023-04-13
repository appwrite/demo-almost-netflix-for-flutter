//
// movies.dart
// appflix
//
// Author: wess (me@wess.io)
// Created: 01/03/2022
//
// Copywrite (c) 2022 Wess.io
//

import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';

import '/api/client.dart';
import '/constants.dart';
import '/data/movie.dart';

class MoviesProvider extends ChangeNotifier {
  static final String _databaseId = ID.custom(AppwriteConstants.databaseId);
  static final String _collectionId = ID.custom(
    AppwriteConstants.moviesCollectionId,
  );

  Movie? _selected;
  Movie? get selected => _selected;

  Movie _featured = Movie.empty();
  Movie get featured => _featured;

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;
  List<Movie> get originals => _movies.where((e) => e.isOriginal).toList();
  List<Movie> get animations =>
      _movies.where((e) => e.genres.contains('Animation')).toList();
  List<Movie> get newReleases => _movies.where((e) {
        final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
        return e.releaseDate != null && e.releaseDate!.isAfter(thirtyDaysAgo);
      }).toList();

  List<Movie> get trending {
    var trending = _movies;

    trending.sort((a, b) => b.trendingIndex.compareTo(a.trendingIndex));

    return trending;
  }

  void setSelected(Movie movie) {
    _selected = movie;

    notifyListeners();
  }

  Future<void> list() async {
    var result = await ApiClient.database
        .listDocuments(databaseId: _databaseId, collectionId: _collectionId);

    _movies = result.documents
        .map((document) => Movie.fromJson(document.data))
        .toList();
    _featured = _movies.isEmpty ? Movie.empty() : _movies[0];

    notifyListeners();
  }
}
