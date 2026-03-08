// To parse this JSON data, do
//
//     final moviePageModel = moviePageModelFromJson(jsonString);

import 'dart:convert';

MoviePopularPageModel moviePageModelFromJson(String str) =>
    MoviePopularPageModel.fromJson(json.decode(str));

String moviePageModelToJson(MoviePopularPageModel data) => json.encode(data.toJson());

class MoviePopularPageModel {
  int? page;
  List<MoviePopularModel>? movies;
  int? totalPages;
  int? totalResults;

  MoviePopularPageModel({
        this.page, this.movies, this.totalPages, this.totalResults,
    });

  factory MoviePopularPageModel.fromJson(Map<String, dynamic> json) => MoviePopularPageModel(
        page: json["page"],
    movies: json["results"] == null
        ? []
        : List<MoviePopularModel>.from(
            json["results"]!.map((x) => MoviePopularModel.fromJson(x)),
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

class MoviePopularModel {
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

  MoviePopularModel({
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

  factory MoviePopularModel.fromJson(Map<String, dynamic> json) =>
      MoviePopularModel(
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
