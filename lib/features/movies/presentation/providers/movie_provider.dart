import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:imdumb/core/network/dio_client.dart';
import 'package:imdumb/features/movies/domain/usecases/get_generes_movies.dart';
import 'package:imdumb/features/movies/domain/usecases/get_movies_by_genre.dart';
import 'package:imdumb/features/movies/domain/usecases/get_now_playing_movies.dart';

import '../../data/datasources/movie_remote_datasource.dart';
import '../../data/repositories/movie_repository_impl.dart';
import '../../domain/usecases/get_credits_movie.dart';
import '../../domain/usecases/get_popular_movies.dart';

/// DIO

final dioProvider = Provider((ref) {
  return DioClient().dio;
});

/// DATASOURCE
final movieDatasourceProvider = Provider((ref) {
  return MovieRemoteDatasourceImpl(ref.read(dioProvider));
});

/// REPOSITORY
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(ref.read(movieDatasourceProvider));
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

/// Género seleccionado (null = mostrar populares)
final selectedGenreIdProvider = StateProvider<int?>((ref) => null);

final moviesByGenreProvider = FutureProvider.family((ref, int genreId) async {
  final usecase = ref.read(getMoviesByGenreProvider);
  return usecase(genreId: genreId, page: 1);
});

final movieCreditsProvider = FutureProvider.family((ref, int movieId) async {
  final usecase = ref.read(getCreditsMovieProvider);
  return usecase(movieId);
});
