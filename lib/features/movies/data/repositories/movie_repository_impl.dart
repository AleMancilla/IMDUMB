import 'dart:developer' as developer;

import 'package:imdumb/features/movies/domain/entities/movie_credits.dart';
import 'package:imdumb/features/movies/domain/entities/movie_details.dart';
import 'package:imdumb/features/movies/domain/entities/movie_generes.dart';
import 'package:imdumb/features/movies/domain/entities/movie_reviews.dart';

import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/local/movie_local_datasource.dart';
import '../datasources/remote/movie_remote_datasource.dart';
import '../mappers/movie_credits_mapper.dart';
import '../mappers/movie_details_mapper.dart';
import '../mappers/movie_generes_mapper.dart';
import '../mappers/movie_mapper.dart';
import '../mappers/movie_review_mapper.dart';

class MovieRepositoryImpl implements MovieRepository {
  MovieRepositoryImpl(this._remote, this._local);

  final MovieRemoteDatasource _remote;
  final MovieLocalDatasource _local;

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    final cached = await _local.getPopularMovies(page);
    if (cached != null) {
      developer.log('📦 [HIVE] Películas populares (page=$page) obtenidas desde caché local');
      return cached.map((m) => m.toEntity()).toList();
    }
    final movies = await _remote.getPopularMovies(page: page);
    await _local.savePopularMovies(page, movies);
    return movies.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<Genre>> getMovieGeneres() async {
    final cached = await _local.getMovieGenres();
    if (cached != null) {
      developer.log('📦 [HIVE] Géneros obtenidos desde caché local');
      return cached.map((g) => g.toEntity()).toList();
    }
    final genres = await _remote.getMovieGeneres();
    await _local.saveMovieGenres(genres);
    return genres.map((g) => g.toEntity()).toList();
  }

  @override
  Future<List<Movie>> getNowPlayingMovies({int page = 1}) async {
    final cached = await _local.getNowPlayingMovies(page);
    if (cached != null) {
      developer.log('📦 [HIVE] Now playing (page=$page) obtenidos desde caché local');
      return cached.map((m) => m.toEntity()).toList();
    }
    final movies = await _remote.getNowPlayingMovies(page: page);
    await _local.saveNowPlayingMovies(page, movies);
    return movies.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<Movie>> getMoviesByGenre(int genreId, {int page = 1}) async {
    final cached = await _local.getMoviesByGenre(genreId, page);
    if (cached != null) {
      developer.log('📦 [HIVE] Películas por género ($genreId, page=$page) obtenidas desde caché local');
      return cached.map((m) => m.toEntity()).toList();
    }
    final movies = await _remote.getMoviesByGenre(genreId, page: page);
    await _local.saveMoviesByGenre(genreId, page, movies);
    return movies.map((m) => m.toEntity()).toList();
  }

  @override
  Future<MovieCredits> getCreditsMovie(int movieId) async {
    final cached = await _local.getCreditsMovie(movieId);
    if (cached != null) {
      developer.log('📦 [HIVE] Créditos de película ($movieId) obtenidos desde caché local');
      return cached.toEntity();
    }
    final credits = await _remote.getCreditsMovie(movieId);
    await _local.saveCreditsMovie(movieId, credits);
    return credits.toEntity();
  }

  @override
  Future<MovieDetails> getDetailsMovie(int movieId) async {
    final cached = await _local.getDetailsMovie(movieId);
    if (cached != null) {
      developer.log('📦 [HIVE] Detalles de película ($movieId) obtenidos desde caché local');
      return cached.toEntity();
    }
    final details = await _remote.getDetailsMovie(movieId);
    await _local.saveDetailsMovie(movieId, details);
    return details.toEntity();
  }

  @override
  Future<List<Movie>> getSimilarMovies(int movieId, {int page = 1}) async {
    final cached = await _local.getSimilarMovies(movieId, page);
    if (cached != null) {
      developer.log('📦 [HIVE] Películas similares ($movieId, page=$page) obtenidas desde caché local');
      return cached.map((m) => m.toEntity()).toList();
    }
    final movies = await _remote.getSimilarMovies(movieId, page: page);
    await _local.saveSimilarMovies(movieId, page, movies);
    return movies.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<MovieReview>> getReviewsMovie(int movieId) async {
    final cached = await _local.getReviewsMovie(movieId);
    if (cached != null) {
      developer.log('📦 [HIVE] Reviews de película ($movieId) obtenidos desde caché local');
      return cached.map((r) => r.toEntity()).toList();
    }
    final reviews = await _remote.getReviewsMovie(movieId);
    await _local.saveReviewsMovie(movieId, reviews);
    return reviews.map((r) => r.toEntity()).toList();
  }

  @override
  Future<List<Movie>> searchMovies(String query, {int page = 1}) async {
    final movies = await _remote.searchMovies(query, page: page);
    return movies.map((m) => m.toEntity()).toList();
  }
}
