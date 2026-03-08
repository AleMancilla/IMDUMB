import 'package:imdumb/features/movies/data/models/movie_now_plaing.dart';
import 'package:imdumb/features/movies/domain/entities/movie_now_playing.dart';

extension MovieNowPlayingMapper on MovieNowPlayingModel {
  MovieNowPlaying toEntity() {
    return MovieNowPlaying(
      adult: adult ?? false,
      backdropPath: backdropPath ?? '',
      genreIds: genreIds ?? [],
      id: id ?? 0,
      originalLanguage: originalLanguage == null
          ? null
          : switch (originalLanguage!) {
              OriginalLanguageModel.EN => OriginalLanguage.EN,
              OriginalLanguageModel.ES => OriginalLanguage.ES,
              OriginalLanguageModel.FI => OriginalLanguage.FI,
            },
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