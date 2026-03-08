import 'package:dio/dio.dart';
import 'package:imdumb/core/constants/api_constants.dart';
import 'package:imdumb/features/movies/data/models/movie_generes_model.dart';
import 'package:imdumb/features/movies/data/models/movie_now_plaing.dart';
import '../models/movie_popular_model.dart';

abstract class MovieRemoteDatasource {
  Future<List<MoviePopularModel>> getPopularMovies({int page = 1});
  Future<List<GenreModel>> getMovieGeneres();
  Future<List<MovieNowPlayingModel>> getNowPlayingMovies({int page = 1});
}

class MovieRemoteDatasourceImpl implements MovieRemoteDatasource {

  final Dio dio;

  MovieRemoteDatasourceImpl(this.dio);

  @override
  Future<List<MoviePopularModel>> getPopularMovies({int page = 1}) async {

    final response = await dio.get(
      ApiConstants.popularMovies,
      queryParameters: {
        "language": "es-ES",
        "page": page
      },
    );

    final results = (response.data["results"] as List)
        .map(
          (movie) => MoviePopularModel.fromJson(movie as Map<String, dynamic>),
        )
        .toList();

    return results;
  }

  @override
  Future<List<GenreModel>> getMovieGeneres() async {
    final response = await dio.get(ApiConstants.movieGeneres);
    final results = (response.data["genres"] as List)
        .map((genre) => GenreModel.fromJson(genre as Map<String, dynamic>))
        .toList();
    return results;
  }
  @override
  Future<List<MovieNowPlayingModel>> getNowPlayingMovies({int page = 1}) async {
    final response = await dio.get(
      ApiConstants.nowPlayingMovies,
      queryParameters: {"language": "es-ES", "page": page},
    );
    final results = (response.data["results"] as List)
        .map(
          (movie) =>
              MovieNowPlayingModel.fromJson(movie as Map<String, dynamic>),
        )
        .toList();
    return results;
  }
}