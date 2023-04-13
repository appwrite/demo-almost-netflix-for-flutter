import 'movie.dart';

class Watchlist {
  final Movie movie;
  final String userId;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> permissions;
  final String databaseId;
  final String collectionId;

  Watchlist({
    required this.movie,
    required this.userId,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.permissions,
    required this.databaseId,
    required this.collectionId,
  });

  factory Watchlist.fromJson(Map<String, dynamic> json) => Watchlist(
        movie: Movie.fromJson(json["movie"]),
        userId: json["userId"],
        id: json["\u0024id"],
        createdAt: DateTime.parse(json["\u0024createdAt"]),
        updatedAt: DateTime.parse(json["\u0024updatedAt"]),
        permissions: List<String>.from(json["\u0024permissions"].map((x) => x)),
        databaseId: json["\u0024databaseId"],
        collectionId: json["\u0024collectionId"],
      );

  Map<String, dynamic> toJson() => {
        "movie": movie.toJson(),
        "userId": userId,
        "\u0024id": id,
        "\u0024createdAt": createdAt.toUtc().toIso8601String(),
        "\u0024updatedAt": updatedAt.toUtc().toIso8601String(),
        "\u0024permissions": List<dynamic>.from(permissions.map((x) => x)),
        "\u0024databaseId": databaseId,
        "\u0024collectionId": collectionId,
      };
}
