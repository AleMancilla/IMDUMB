import 'package:imdumb/features/movies/domain/entities/movie_credits.dart';
import 'package:imdumb/features/movies/domain/entities/movie_details.dart';
import 'package:imdumb/features/movies/domain/entities/movie_generes.dart';

import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_remote_datasource.dart';
import '../mappers/movie_generes_mapper.dart';
import '../mappers/movie_mapper.dart';
import '../mappers/movie_credits_mapper.dart';
import '../mappers/movie_details_mapper.dart';


class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDatasource remoteDatasource;

  MovieRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    final movies = await remoteDatasource.getPopularMovies(page: page);
    return movies.map((movie) => movie.toEntity()).toList();
  }

  @override
  Future<List<Genre>> getMovieGeneres() async {
    final genres = await remoteDatasource.getMovieGeneres();
    return genres.map((genre) => genre.toEntity()).toList();
  }

  @override
  Future<List<Movie>> getNowPlayingMovies({int page = 1}) async {
    final movies = await remoteDatasource.getNowPlayingMovies(page: page);
    return movies.map((movie) => movie.toEntity()).toList();
  }

  @override
  Future<List<Movie>> getMoviesByGenre(int genreId, {int page = 1}) async {
    final movies = await remoteDatasource.getMoviesByGenre(genreId, page: page);
    return movies.map((movie) => movie.toEntity()).toList();
  }

  @override
  Future<MovieCredits> getCreditsMovie(int movieId) async {
    final credits = await remoteDatasource.getCreditsMovie(movieId);
    return credits.toEntity();
  }

  @override
  Future<MovieDetails> getDetailsMovie(int movieId) async {
    final details = await remoteDatasource.getDetailsMovie(movieId);
    return details.toEntity();
  }

  @override
  Future<List<Movie>> getSimilarMovies(int movieId, {int page = 1}) async {
    final movies = await remoteDatasource.getSimilarMovies(movieId, page: page);
    return movies.map((movie) => movie.toEntity()).toList();
  }
}
