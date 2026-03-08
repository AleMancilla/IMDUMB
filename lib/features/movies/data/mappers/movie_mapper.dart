import 'package:imdumb/features/movies/data/models/movie_model.dart';
import 'package:imdumb/features/movies/domain/entities/movie.dart';

extension MovieMapper on MovieModel {

  Movie toEntity() {
    return Movie(
      adult: adult ?? false,
      backdropPath: backdropPath ?? '',
      genreIds: genreIds ?? [],
      id: id ?? 0,
      originalLanguage: originalLanguage ?? '',
      originalTitle: originalTitle ?? '',
      overview: overview ?? '',
      popularity: popularity ?? 0,
      posterPath: posterPath ?? '',
      releaseDate: releaseDate ?? DateTime.now(),
      title: title ?? '',
      video: video ?? false,
      voteAverage: voteAverage ?? 0,
      voteCount: voteCount ?? 0,
    );
  }
}