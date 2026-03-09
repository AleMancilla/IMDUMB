// To parse this JSON data, do
//
//     final movieCreditsModel = movieCreditsModelFromJson(jsonString);

import 'dart:convert';

MovieCreditsModel movieCreditsModelFromJson(String str) => MovieCreditsModel.fromJson(json.decode(str));

String movieCreditsModelToJson(MovieCreditsModel data) => json.encode(data.toJson());

class MovieCreditsModel {
    int? id;
    List<CastModel>? cast;
    List<CastModel>? crew;

    MovieCreditsModel({
        this.id,
        this.cast,
        this.crew,
    });

    factory MovieCreditsModel.fromJson(Map<String, dynamic> json) => MovieCreditsModel(
        id: json["id"],
        cast: json["cast"] == null ? [] : List<CastModel>.from(json["cast"]!.map((x) => CastModel.fromJson(x))),
        crew: json["crew"] == null ? [] : List<CastModel>.from(json["crew"]!.map((x) => CastModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cast": cast == null ? [] : List<dynamic>.from(cast!.map((x) => x.toJson())),
        "crew": crew == null ? [] : List<dynamic>.from(crew!.map((x) => x.toJson())),
    };
}

class CastModel {
    bool? adult;
    int? gender;
    int? id;
    String? knownForDepartment;
    String? name;
    String? originalName;
    double? popularity;
    String? profilePath;
    int? castId;
    String? character;
    String? creditId;
    int? order;
    String? department;
    String? job;

    CastModel({
        this.adult,
        this.gender,
        this.id,
        this.knownForDepartment,
        this.name,
        this.originalName,
        this.popularity,
        this.profilePath,
        this.castId,
        this.character,
        this.creditId,
        this.order,
        this.department,
        this.job,
    });

    factory CastModel.fromJson(Map<String, dynamic> json) => CastModel(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
        department: json["department"],
        job: json["job"],
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": knownForDepartment,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "cast_id": castId,
        "character": character,
        "credit_id": creditId,
        "order": order,
        "department": department,
        "job": job,
    };
}
