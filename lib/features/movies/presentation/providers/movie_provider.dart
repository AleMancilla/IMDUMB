import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:imdumb/core/network/dio_client.dart';
import 'package:imdumb/features/movies/domain/usecases/get_generes_movies.dart';
import 'package:imdumb/features/movies/domain/usecases/get_movies_by_genre.dart';
import 'package:imdumb/features/movies/domain/usecases/get_now_playing_movies.dart';

import '../../data/datasources/local/movie_local_datasource.dart';
import '../../data/datasources/local/movie_local_datasource_impl.dart';
import '../../data/datasources/remote/movie_remote_datasource.dart';
import '../../data/repositories/movie_repository_impl.dart';
import '../../domain/usecases/get_credits_movie.dart';
import '../../domain/usecases/get_details_movie.dart';
import '../../domain/usecases/get_popular_movies.dart';
import '../../domain/usecases/get_reviews_movie.dart';
import '../../domain/usecases/get_similar_movies.dart';

/// DIO

final dioProvider = Provider((ref) {
  return DioClient().dio;
});

final movieCacheBoxProvider = Provider<Box<dynamic>>((ref) {
  throw UnsupportedError(
    'movieCacheBoxProvider must be overridden in main with Hive.openBox()',
  );
});

/// DATASOURCES
final movieRemoteDatasourceProvider = Provider((ref) {
  return MovieRemoteDatasourceImpl(ref.read(dioProvider));
});

final movieLocalDatasourceProvider = Provider<MovieLocalDatasource>((ref) {
  return MovieLocalDatasourceImpl(ref.read(movieCacheBoxProvider));
});

/// REPOSITORY (usa remote + local para caché)
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(
    ref.read(movieRemoteDatasourceProvider),
    ref.read(movieLocalDatasourceProvider),
  );
});

/// USECASES
final getPopularMoviesProvider = Provider((ref) {
  return GetPopularMovies(ref.read(movieRepositoryProvider));
});

final getGeneresMoviesProvider = Provider((ref) {
  return GetGeneresMovies(ref.read(movieRepositoryProvider));
});

final getNowPlayingMoviesProvider = Provider((ref) {
  return GetNowPlayingMovies(ref.read(movieRepositoryProvider));
});

final getMoviesByGenreProvider = Provider((ref) {
  return GetMoviesByGenre(ref.read(movieRepositoryProvider));
});

final getCreditsMovieProvider = Provider((ref) {
  return GetCreditsMovie(ref.read(movieRepositoryProvider));
});

final getDetailsMovieProvider = Provider((ref) {
  return GetDetailsMovie(ref.read(movieRepositoryProvider));
});

final getSimilarMoviesProvider = Provider((ref) {
  return GetSimilarMovies(ref.read(movieRepositoryProvider));
});

final getReviewsMovieProvider = Provider((ref) {
  return GetReviewsMovie(ref.read(movieRepositoryProvider));
});

/// UI PROVIDERS
final popularMoviesProvider = FutureProvider.family((ref, int page) async {
  final usecase = ref.read(getPopularMoviesProvider);
  return usecase(page: page);
});

final generesMoviesProvider = FutureProvider((ref) async {
  final usecase = ref.read(getGeneresMoviesProvider);
  return usecase();
});

final nowPlayingMoviesProvider = FutureProvider.family((ref, int page) async {
  final usecase = ref.read(getNowPlayingMoviesProvider);
  return usecase(page: page);
});

final selectedGenreIdProvider = StateProvider<int?>((ref) => null);
final moviesByGenreProvider = FutureProvider.family((ref, int genreId) async {
  final usecase = ref.read(getMoviesByGenreProvider);
  return usecase(genreId: genreId, page: 1);
});

final movieCreditsProvider = FutureProvider.family((ref, int movieId) async {
  final usecase = ref.read(getCreditsMovieProvider);
  return usecase(movieId);
});

final movieDetailsProvider = FutureProvider.family((ref, int movieId) async {
  final usecase = ref.read(getDetailsMovieProvider);
  return usecase(movieId);
});

final similarMoviesProvider = FutureProvider.family((ref, int movieId) async {
  final usecase = ref.read(getSimilarMoviesProvider);
  return usecase(movieId, page: 1);
});

final movieReviewsProvider = FutureProvider.family((ref, int movieId) async {
  final usecase = ref.read(getReviewsMovieProvider);
  return usecase(movieId);
});
