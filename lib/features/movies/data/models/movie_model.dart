// To parse this JSON data, do
//
//     final moviePageModel = moviePageModelFromJson(jsonString);

import 'dart:convert';

MoviePageModel moviePageModelFromJson(String str) =>
    MoviePageModel.fromJson(json.decode(str));

String moviePageModelToJson(MoviePageModel data) => json.encode(data.toJson());

class MoviePageModel {
  int? page;
  List<MovieModel>? movies;
  int? totalPages;
  int? totalResults;

  MoviePageModel({
        this.page, this.movies, this.totalPages, this.totalResults,
    });

  factory MoviePageModel.fromJson(Map<String, dynamic> json) => MoviePageModel(
        page: json["page"],
    movies: json["results"] == null
        ? []
        : List<MovieModel>.from(
            json["results"]!.map((x) => MovieModel.fromJson(x)),
          ),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
    "results": movies == null
        ? []
        : List<dynamic>.from(movies!.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}

class MovieModel {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  DateTime? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  MovieModel({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
    genreIds: json["genre_ids"] == null
        ? []
        : List<int>.from(json["genre_ids"]!.map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
    releaseDate: json["release_date"] == null
        ? null
        : DateTime.parse(json["release_date"]),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
    "genre_ids": genreIds == null
        ? []
        : List<dynamic>.from(genreIds!.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
    "release_date":
        "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
}
