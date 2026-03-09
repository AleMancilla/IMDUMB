// To parse this JSON data, do
//
//     final movieReviewsModel = movieReviewsModelFromJson(jsonString);

import 'dart:convert';

MovieReviewsPageModel movieReviewsModelFromJson(String str) => MovieReviewsPageModel.fromJson(json.decode(str));

String movieReviewsModelToJson(MovieReviewsPageModel data) => json.encode(data.toJson());

class MovieReviewsPageModel {
    int? id;
    int? page;
    List<MovieReviewModel>? results;
    int? totalPages;
    int? totalResults;

    MovieReviewsPageModel({
        this.id,
        this.page,
        this.results,
        this.totalPages,
        this.totalResults,
    });

    factory MovieReviewsPageModel.fromJson(Map<String, dynamic> json) => MovieReviewsPageModel(
        id: json["id"],
        page: json["page"],
        results: json["results"] == null ? [] : List<MovieReviewModel>.from(json["results"]!.map((x) => MovieReviewModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "page": page,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}

class MovieReviewModel {
    String? author;
    AuthorDetailsModel? authorDetails;
    String? content;
    DateTime? createdAt;
    String? id;
    DateTime? updatedAt;
    String? url;

    MovieReviewModel({
        this.author,
        this.authorDetails,
        this.content,
        this.createdAt,
        this.id,
        this.updatedAt,
        this.url,
    });

    factory MovieReviewModel.fromJson(Map<String, dynamic> json) => MovieReviewModel(
        author: json["author"],
        authorDetails: json["author_details"] == null ? null : AuthorDetailsModel.fromJson(json["author_details"]),
        content: json["content"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "author": author,
        "author_details": authorDetails?.toJson(),
        "content": content,
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "updated_at": updatedAt?.toIso8601String(),
        "url": url,
    };
}

class AuthorDetailsModel {
    String? name;
    String? username;
    String? avatarPath;
    double? rating;

    AuthorDetailsModel({
        this.name,
        this.username,
        this.avatarPath,
        this.rating,
    });

    factory AuthorDetailsModel.fromJson(Map<String, dynamic> json) => AuthorDetailsModel(
        name: json["name"],
        username: json["username"],
        avatarPath: json["avatar_path"],
        rating: json["rating"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "avatar_path": avatarPath,
        "rating": rating,
    };
}
