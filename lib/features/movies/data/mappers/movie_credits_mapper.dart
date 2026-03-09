import 'package:imdumb/features/movies/data/models/movie_credits_model.dart';
import 'package:imdumb/features/movies/domain/entities/movie_credits.dart';

extension MovieCreditsMapper on MovieCreditsModel {
  MovieCredits toEntity() {
    return MovieCredits(
      id: id,
      cast: cast?.map((c) => c.toEntity()).toList(),
      crew: crew?.map((c) => c.toEntity()).toList(),
    );
  }
}

extension CastMapper on CastModel {
  Cast toEntity() {
    return Cast(
      adult: adult,
      gender: gender,
      id: id,
      knownForDepartment: knownForDepartment,
      name: name,
      originalName: originalName,
      popularity: popularity,
      profilePath: profilePath,
      castId: castId,
      character: character,
      creditId: creditId,
      order: order,
      department: department,
      job: job,
    );
  }
}