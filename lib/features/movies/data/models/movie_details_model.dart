// To parse this JSON data, do
//
//     final movieDetailsModel = movieDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:imdumb/features/movies/data/models/movie_generes_model.dart';

MovieDetailsModel movieDetailsModelFromJson(String str) => MovieDetailsModel.fromJson(json.decode(str));

String movieDetailsModelToJson(MovieDetailsModel data) => json.encode(data.toJson());

class MovieDetailsModel {
    bool? adult;
    String? backdropPath;
    BelongsToCollectionModel? belongsToCollection;
    int? budget;
    List<GenreModel>? genres;
    String? homepage;
    int? id;
    String? imdbId;
    List<String>? originCountry;
    String? originalLanguage;
    String? originalTitle;
    String? overview;
    double? popularity;
    String? posterPath;
    List<ProductionCompanyModel>? productionCompanies;
    List<ProductionCountryModel>? productionCountries;
    DateTime? releaseDate;
    int? revenue;
    int? runtime;
    List<SpokenLanguageModel>? spokenLanguages;
    String? status;
    String? tagline;
    String? title;
    bool? video;
    double? voteAverage;
    int? voteCount;

    MovieDetailsModel({
        this.adult,
        this.backdropPath,
        this.belongsToCollection,
        this.budget,
        this.genres,
        this.homepage,
        this.id,
        this.imdbId,
        this.originCountry,
        this.originalLanguage,
        this.originalTitle,
        this.overview,
        this.popularity,
        this.posterPath,
        this.productionCompanies,
        this.productionCountries,
        this.releaseDate,
        this.revenue,
        this.runtime,
        this.spokenLanguages,
        this.status,
        this.tagline,
        this.title,
        this.video,
        this.voteAverage,
        this.voteCount,
    });

    factory MovieDetailsModel.fromJson(Map<String, dynamic> json) => MovieDetailsModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        belongsToCollection: json["belongs_to_collection"] == null ? null : BelongsToCollectionModel.fromJson(json["belongs_to_collection"]),
        budget: json["budget"],
        genres: json["genres"] == null ? [] : List<GenreModel>.from(json["genres"]!.map((x) => GenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        imdbId: json["imdb_id"],
        originCountry: json["origin_country"] == null ? [] : List<String>.from(json["origin_country"]!.map((x) => x)),
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        productionCompanies: json["production_companies"] == null ? [] : List<ProductionCompanyModel>.from(json["production_companies"]!.map((x) => ProductionCompanyModel.fromJson(x))),
        productionCountries: json["production_countries"] == null ? [] : List<ProductionCountryModel>.from(json["production_countries"]!.map((x) => ProductionCountryModel.fromJson(x))),
        releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
        revenue: json["revenue"],
        runtime: json["runtime"],
        spokenLanguages: json["spoken_languages"] == null ? [] : List<SpokenLanguageModel>.from(json["spoken_languages"]!.map((x) => SpokenLanguageModel.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "belongs_to_collection": belongsToCollection?.toJson(),
        "budget": budget,
        "genres": genres == null ? [] : List<dynamic>.from(genres!.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "imdb_id": imdbId,
        "origin_country": originCountry == null ? [] : List<dynamic>.from(originCountry!.map((x) => x)),
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "production_companies": productionCompanies == null ? [] : List<dynamic>.from(productionCompanies!.map((x) => x.toJson())),
        "production_countries": productionCountries == null ? [] : List<dynamic>.from(productionCountries!.map((x) => x.toJson())),
        "release_date": "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "revenue": revenue,
        "runtime": runtime,
        "spoken_languages": spokenLanguages == null ? [] : List<dynamic>.from(spokenLanguages!.map((x) => x.toJson())),
        "status": status,
        "tagline": tagline,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
}

class BelongsToCollectionModel {
    int? id;
    String? name;
    String? posterPath;
    String? backdropPath;

    BelongsToCollectionModel({
        this.id,
        this.name,
        this.posterPath,
        this.backdropPath,
    });

    factory BelongsToCollectionModel.fromJson(Map<String, dynamic> json) => BelongsToCollectionModel(
        id: json["id"],
        name: json["name"],
        posterPath: json["poster_path"],
        backdropPath: json["backdrop_path"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "poster_path": posterPath,
        "backdrop_path": backdropPath,
    };
}

class ProductionCompanyModel {
    int? id;
    String? logoPath;
    String? name;
    String? originCountry;

    ProductionCompanyModel({
        this.id,
        this.logoPath,
        this.name,
        this.originCountry,
    });

    factory ProductionCompanyModel.fromJson(Map<String, dynamic> json) => ProductionCompanyModel(
        id: json["id"],
        logoPath: json["logo_path"],
        name: json["name"],
        originCountry: json["origin_country"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "logo_path": logoPath,
        "name": name,
        "origin_country": originCountry,
    };
}

class ProductionCountryModel {
    String? iso31661;
    String? name;

    ProductionCountryModel({
        this.iso31661,
        this.name,
    });

    factory ProductionCountryModel.fromJson(Map<String, dynamic> json) => ProductionCountryModel(
        iso31661: json["iso_3166_1"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "iso_3166_1": iso31661,
        "name": name,
    };
}

class SpokenLanguageModel {
    String? englishName;
    String? iso6391;
    String? name;

    SpokenLanguageModel({
        this.englishName,
        this.iso6391,
        this.name,
    });

    factory SpokenLanguageModel.fromJson(Map<String, dynamic> json) => SpokenLanguageModel(
        englishName: json["english_name"],
        iso6391: json["iso_639_1"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "english_name": englishName,
        "iso_639_1": iso6391,
        "name": name,
    };
}
