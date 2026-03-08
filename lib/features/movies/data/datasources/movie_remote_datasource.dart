import 'package:dio/dio.dart';
import '../models/movie_model.dart';

abstract class MovieRemoteDatasource {
  Future<List<MovieModel>> getPopularMovies({int page = 1});
}

class MovieRemoteDatasourceImpl implements MovieRemoteDatasource {

  final Dio dio;

  MovieRemoteDatasourceImpl(this.dio);

  @override
  Future<List<MovieModel>> getPopularMovies({int page = 1}) async {

    final response = await dio.get(
      "/movie/popular",
      queryParameters: {
        "language": "es-ES",
        "page": page
      },
    );

    final results = (response.data["results"] as List)
        .map((movie) => MovieModel.fromJson(movie as Map<String, dynamic>))
        .toList();

    return results;
  }
}