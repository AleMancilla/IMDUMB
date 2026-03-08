// To parse this JSON data, do
//
//     final movieNowPlayingPageModel = movieNowPlayingPageModelFromJson(jsonString);

import 'dart:convert';

MovieNowPlayingPageModel movieNowPlayingPageModelFromJson(String str) => MovieNowPlayingPageModel.fromJson(json.decode(str));

String movieNowPlayingPageModelToJson(MovieNowPlayingPageModel data) => json.encode(data.toJson());

class MovieNowPlayingPageModel {
    Dates? dates;
    int? page;
    List<MovieNowPlayingModel>? results;
    int? totalPages;
    int? totalResults;

    MovieNowPlayingPageModel({
        this.dates,
        this.page,
        this.results,
        this.totalPages,
        this.totalResults,
    });

    factory MovieNowPlayingPageModel.fromJson(Map<String, dynamic> json) => MovieNowPlayingPageModel(
        dates: json["dates"] == null ? null : Dates.fromJson(json["dates"]),
        page: json["page"],
        results: json["results"] == null ? [] : List<MovieNowPlayingModel>.from(json["results"]!.map((x) => MovieNowPlayingModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "dates": dates?.toJson(),
        "page": page,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}

class Dates {
    DateTime? maximum;
    DateTime? minimum;

    Dates({
        this.maximum,
        this.minimum,
    });

    factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: json["maximum"] == null ? null : DateTime.parse(json["maximum"]),
        minimum: json["minimum"] == null ? null : DateTime.parse(json["minimum"]),
    );

    Map<String, dynamic> toJson() => {
        "maximum": "${maximum!.year.toString().padLeft(4, '0')}-${maximum!.month.toString().padLeft(2, '0')}-${maximum!.day.toString().padLeft(2, '0')}",
        "minimum": "${minimum!.year.toString().padLeft(4, '0')}-${minimum!.month.toString().padLeft(2, '0')}-${minimum!.day.toString().padLeft(2, '0')}",
    };
}

class MovieNowPlayingModel {
    bool? adult;
    String? backdropPath;
    List<int>? genreIds;
    int? id;
    OriginalLanguageModel? originalLanguage;
    String? originalTitle;
    String? overview;
    double? popularity;
    String? posterPath;
    DateTime? releaseDate;
    String? title;
    bool? video;
    double? voteAverage;
    int? voteCount;

    MovieNowPlayingModel({
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

    factory MovieNowPlayingModel.fromJson(Map<String, dynamic> json) => MovieNowPlayingModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: json["genre_ids"] == null
            ? []
            : List<int>.from((json["genre_ids"] as List).map((x) => x is int ? x : int.tryParse(x.toString()) ?? 0)),
        id: json["id"],
        originalLanguage: json["original_language"] == null
            ? null
            : originalLanguageValues.map[json["original_language"].toString()],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
        "id": id,
        "original_language": originalLanguage == null ? null : originalLanguageValues.reverse[originalLanguage],
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
}

enum OriginalLanguageModel {
    EN,
    ES,
    FI
}

final originalLanguageValues = EnumValues({
    "en": OriginalLanguageModel.EN,
    "es": OriginalLanguageModel.ES,
    "fi": OriginalLanguageModel.FI
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
