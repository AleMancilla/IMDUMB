// To parse this JSON data, do
//
//     final movieGeneresModel = movieGeneresModelFromJson(jsonString);

import 'dart:convert';

MovieGeneresModel movieGeneresModelFromJson(String str) => MovieGeneresModel.fromJson(json.decode(str));

String movieGeneresModelToJson(MovieGeneresModel data) => json.encode(data.toJson());

class MovieGeneresModel {
    List<GenreModel> genres;

    MovieGeneresModel({
        required this.genres,
    });

    factory MovieGeneresModel.fromJson(Map<String, dynamic> json) => MovieGeneresModel(
        genres: List<GenreModel>.from(json["genres"].map((x) => GenreModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    };
}

class GenreModel {
    int id;
    String name;

    GenreModel({
        required this.id,
        required this.name,
    });

    factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
