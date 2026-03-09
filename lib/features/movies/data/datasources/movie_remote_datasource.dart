import 'package:dio/dio.dart';
import 'package:imdumb/core/constants/api_constants.dart';
import 'package:imdumb/features/movies/data/models/movie_credits_model.dart';
import 'package:imdumb/features/movies/data/models/movie_details_model.dart';
import 'package:imdumb/features/movies/data/models/movie_generes_model.dart';
import '../models/movie_model.dart';

abstract class MovieRemoteDatasource {
  Future<List<MovieModel>> getPopularMovies({int page = 1});
  Future<List<GenreModel>> getMovieGeneres();
  Future<List<MovieModel>> getNowPlayingMovies({int page = 1});
  Future<List<MovieModel>> getMoviesByGenre(int genreId, {int page = 1});
  Future<MovieCreditsModel> getCreditsMovie(int movieId);
  Future<MovieDetailsModel> getDetailsMovie(int movieId);
  Future<List<MovieModel>> getSimilarMovies(int movieId, {int page = 1});
}

class MovieRemoteDatasourceImpl implements MovieRemoteDatasource {
  final Dio dio;

  MovieRemoteDatasourceImpl(this.dio);


  @override
  Future<List<MovieModel>> getPopularMovies({int page = 1}) async {
    final response = await dio.get(
      ApiConstants.popularMovies,
      queryParameters: {"language": "es-ES", "page": page},
    );
    return _parseMovieList(response.data["results"]);
  }

  @override
  Future<List<GenreModel>> getMovieGeneres() async {
    final response = await dio.get(
      ApiConstants.movieGeneres,
      queryParameters: {"language": "es-ES"},
    );
    return _parseGenreList(response.data["genres"]);
  }

  @override
  Future<List<MovieModel>> getNowPlayingMovies({int page = 1}) async {
    final response = await dio.get(
      ApiConstants.nowPlayingMovies,
      queryParameters: {"language": "es-ES", "page": page},
    );
    return _parseMovieList(response.data["results"]);
  }

  @override
  Future<List<MovieModel>> getMoviesByGenre(int genreId, {int page = 1}) async {
    final response = await dio.get(
      ApiConstants.discoverMovies,
      queryParameters: {
        "include_adult": false,
        "include_video": true,
        "language": "es-ES",
        "page": page,
        "sort_by": "popularity.desc",
        "with_genres": genreId,
      },
    );
    return _parseMovieList(response.data["results"]);
  }

  @override
  Future<MovieCreditsModel> getCreditsMovie(int movieId) async {
    final response = await dio.get(
      ApiConstants.movieCreditlUrl(movieId),
      queryParameters: {"language": "es-ES"},
    );
    return MovieCreditsModel.fromJson(response.data);
  }

  @override
  Future<MovieDetailsModel> getDetailsMovie(int movieId) async {
    final response = await dio.get(
      ApiConstants.movieDetailUrl(movieId),
      queryParameters: {"language": "es-ES"},
    );
    return MovieDetailsModel.fromJson(response.data);
  }

  @override
  Future<List<MovieModel>> getSimilarMovies(int movieId, {int page = 1}) async {
    final response = await dio.get(
      ApiConstants.similarMovieUrl(movieId),
      queryParameters: {"language": "es-ES", "page": page},
    );
    return _parseMovieList(response.data["results"]);
  }

  List<MovieModel> _parseMovieList(dynamic raw) {
    if (raw == null || raw is! List) return [];
    final List<MovieModel> results = [];
    for (final item in raw) {
      if (item is! Map<String, dynamic>) continue;
      try {
        results.add(MovieModel.fromJson(item));
      } catch (_) {
        // Ignorar items que no parsean
      }
    }
    return results;
  }

  List<GenreModel> _parseGenreList(dynamic raw) {
    if (raw == null || raw is! List) return [];
    final List<GenreModel> results = [];
    for (final item in raw) {
      if (item is! Map<String, dynamic>) continue;
      try {
        results.add(GenreModel.fromJson(item));
      } catch (_) {
        // Ignorar items que no parsean
      }
    }
    return results;
  }
}