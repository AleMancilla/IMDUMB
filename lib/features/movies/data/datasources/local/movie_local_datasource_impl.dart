import 'package:hive_flutter/hive_flutter.dart';
import 'package:imdumb/features/movies/data/datasources/local/movie_local_datasource.dart';
import 'package:imdumb/features/movies/data/models/movie_credits_model.dart';
import 'package:imdumb/features/movies/data/models/movie_details_model.dart';
import 'package:imdumb/features/movies/data/models/movie_generes_model.dart';
import 'package:imdumb/features/movies/data/models/movie_reviews_model.dart';
import 'package:imdumb/features/movies/data/models/movie_model.dart';

const String _boxName = 'movie_cache';

abstract final class _CacheKeys {
  static String popularMovies(int page) => 'popular_movies_$page';
  static const String genres = 'genres';
  static String nowPlaying(int page) => 'now_playing_$page';
  static String moviesByGenre(int genreId, int page) =>
      'movies_by_genre_${genreId}_$page';
  static String credits(int movieId) => 'credits_$movieId';
  static String details(int movieId) => 'details_$movieId';
  static String similar(int movieId, int page) => 'similar_${movieId}_$page';
  static String reviews(int movieId) => 'reviews_$movieId';
}

class MovieLocalDatasourceImpl implements MovieLocalDatasource {
  MovieLocalDatasourceImpl(this._box);

  final Box<dynamic> _box;

  static Future<Box<dynamic>> openBox() => Hive.openBox<dynamic>(_boxName);

  @override
  Future<List<MovieModel>?> getPopularMovies(int page) async {
    return _getMovieList(_CacheKeys.popularMovies(page));
  }

  @override
  Future<void> savePopularMovies(int page, List<MovieModel> movies) async {
    await _saveMovieList(_CacheKeys.popularMovies(page), movies);
  }

  @override
  Future<List<GenreModel>?> getMovieGenres() async {
    final raw = _box.get(_CacheKeys.genres);
    if (raw == null || raw is! List) return null;
    try {
      return raw
          .map((e) => GenreModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveMovieGenres(List<GenreModel> genres) async {
    await _box.put(
      _CacheKeys.genres,
      genres.map((g) => g.toJson()).toList(),
    );
  }

  @override
  Future<List<MovieModel>?> getNowPlayingMovies(int page) async {
    return _getMovieList(_CacheKeys.nowPlaying(page));
  }

  @override
  Future<void> saveNowPlayingMovies(int page, List<MovieModel> movies) async {
    await _saveMovieList(_CacheKeys.nowPlaying(page), movies);
  }

  @override
  Future<List<MovieModel>?> getMoviesByGenre(int genreId, int page) async {
    return _getMovieList(_CacheKeys.moviesByGenre(genreId, page));
  }

  @override
  Future<void> saveMoviesByGenre(
    int genreId,
    int page,
    List<MovieModel> movies,
  ) async {
    await _saveMovieList(_CacheKeys.moviesByGenre(genreId, page), movies);
  }

  @override
  Future<MovieCreditsModel?> getCreditsMovie(int movieId) async {
    final raw = _box.get(_CacheKeys.credits(movieId));
    if (raw == null || raw is! Map) return null;
    try {
      return MovieCreditsModel.fromJson(
        Map<String, dynamic>.from(raw),
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveCreditsMovie(
    int movieId,
    MovieCreditsModel credits,
  ) async {
    await _box.put(_CacheKeys.credits(movieId), credits.toJson());
  }

  @override
  Future<MovieDetailsModel?> getDetailsMovie(int movieId) async {
    final raw = _box.get(_CacheKeys.details(movieId));
    if (raw == null || raw is! Map) return null;
    try {
      return MovieDetailsModel.fromJson(
        Map<String, dynamic>.from(raw),
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveDetailsMovie(
    int movieId,
    MovieDetailsModel details,
  ) async {
    await _box.put(_CacheKeys.details(movieId), details.toJson());
  }

  @override
  Future<List<MovieModel>?> getSimilarMovies(int movieId, int page) async {
    return _getMovieList(_CacheKeys.similar(movieId, page));
  }

  @override
  Future<void> saveSimilarMovies(
    int movieId,
    int page,
    List<MovieModel> movies,
  ) async {
    await _saveMovieList(_CacheKeys.similar(movieId, page), movies);
  }

  @override
  Future<List<MovieReviewModel>?> getReviewsMovie(int movieId) async {
    final raw = _box.get(_CacheKeys.reviews(movieId));
    if (raw == null || raw is! List) return null;
    try {
      return raw
          .map(
            (e) => MovieReviewModel.fromJson(
              Map<String, dynamic>.from(e as Map),
            ),
          )
          .toList();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveReviewsMovie(
    int movieId,
    List<MovieReviewModel> reviews,
  ) async {
    await _box.put(
      _CacheKeys.reviews(movieId),
      reviews.map((r) => r.toJson()).toList(),
    );
  }

  Future<List<MovieModel>?> _getMovieList(String key) async {
    final raw = _box.get(key);
    if (raw == null || raw is! List) return null;
    try {
      return raw
          .map(
            (e) => MovieModel.fromJson(Map<String, dynamic>.from(e as Map)),
          )
          .toList();
    } catch (_) {
      return null;
    }
  }

  Future<void> _saveMovieList(String key, List<MovieModel> movies) async {
    await _box.put(key, movies.map((m) => m.toJson()).toList());
  }
}
