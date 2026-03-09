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
}

class MovieRemoteDatasourceImpl implements MovieRemoteDatasource {

  final Dio dio;

  MovieRemoteDatasourceImpl(this.dio);

  @override
  Future<List<MovieModel>> getPopularMovies({int page = 1}) async {

    final response = await dio.get(
      ApiConstants.popularMovies,
      queryParameters: {
        "language": "es-ES",
        "page": page
      },
    );

    final results = (response.data["results"] as List)
        .map(
          (movie) => MovieModel.fromJson(movie as Map<String, dynamic>),
        )
        .toList();

    return results;
  }

  @override
  Future<List<GenreModel>> getMovieGeneres() async {
    final response = await dio.get(
      ApiConstants.movieGeneres,
      queryParameters: {"language": "es-ES"},
    );
    final results = (response.data["genres"] as List)
        .map((genre) => GenreModel.fromJson(genre as Map<String, dynamic>))
        .toList();
    return results;
  }
  @override
  Future<List<MovieModel>> getNowPlayingMovies({int page = 1}) async {
    final response = await dio.get(
      ApiConstants.nowPlayingMovies,
      queryParameters: {"language": "es-ES", "page": page},
    );
    final results = (response.data["results"] as List)
        .map(
          (movie) =>
              MovieModel.fromJson(movie as Map<String, dynamic>),
        )
        .toList();
    return results;
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
    final results = (response.data["results"] as List)
        .map(
          (movie) => MovieModel.fromJson(movie as Map<String, dynamic>),
        )
        .toList();
    return results;
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
}