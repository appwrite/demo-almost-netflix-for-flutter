//
// movie.dart
// appflix
//
// Author: wess (me@wess.io)
// Created: 01/03/2022
//
// Copywrite (c) 2022 Wess.io
//

import '/constants.dart';

class Movie {
  final String id;
  final String name;
  final String? description;
  final String ageRestriction;
  final Duration durationMinutes;
  final String thumbnailImageId;
  final List<String> genres;
  final List<String> tags;
  final DateTime? netflixReleaseDate;
  final DateTime? releaseDate;
  final double trendingIndex;
  final bool isOriginal;
  final List<String> cast;

  bool isEmpty() {
    if (id.isEmpty || name.isEmpty) {
      return true;
    }

    return false;
  }

  String get thumbnailImageUrl => thumbnailImageId.isEmpty
      ? ""
      : "${AppwriteConstants.endpoint}/storage/buckets/${AppwriteConstants.postersBucketId}/files/$thumbnailImageId/view?project=${AppwriteConstants.projectId}";

  Movie({
    required this.id,
    required this.name,
    this.description,
    required this.ageRestriction,
    required this.durationMinutes,
    required this.thumbnailImageId,
    required this.genres,
    required this.tags,
    this.netflixReleaseDate,
    this.releaseDate,
    required this.trendingIndex,
    required this.isOriginal,
    required this.cast,
  });

  static Movie empty() {
    return Movie(
      id: '',
      name: '',
      description: '',
      ageRestriction: '',
      durationMinutes: const Duration(minutes: -1),
      thumbnailImageId: '',
      genres: [],
      tags: [],
      trendingIndex: -1,
      isOriginal: false,
      cast: [],
    );
  }

  factory Movie.fromJson(Map<String, dynamic> data) {
    return Movie(
      id: data['\$id'],
      name: data['name'],
      description: data['description'],
      ageRestriction: data['ageRestriction'],
      durationMinutes: Duration(minutes: data['durationMinutes']),
      thumbnailImageId: data['thumbnailImageId'],
      genres: data['genres'].cast<String>(),
      tags: data['tags'].cast<String>(),
      netflixReleaseDate: data['netflixReleaseDate'] != null
          ? DateTime.parse(data['netflixReleaseDate'])
          : null,
      releaseDate: data['releaseDate'] != null
          ? DateTime.parse(data['releaseDate'])
          : null,
      trendingIndex: data['trendingIndex'],
      isOriginal: data['isOriginal'],
      cast: data['cast'].cast<String>(),
    );
  }

  Map<String, dynamic> toJson() => {
        '\$id': id,
        'name': name,
        'description': description,
        'ageRestriction': ageRestriction,
        'durationMinutes': durationMinutes.inMinutes,
        'thumbnailImageId': thumbnailImageId,
        'genres': genres,
        'tags': tags,
        'netflixReleaseDate': netflixReleaseDate?.toUtc().toIso8601String(),
        'releaseDate': releaseDate?.toUtc().toIso8601String(),
        'trendingIndex': trendingIndex,
        'isOriginal': isOriginal,
        'cast': cast,
      };
}
