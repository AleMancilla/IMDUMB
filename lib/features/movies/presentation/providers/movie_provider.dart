import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imdumb/core/network/dio_client.dart';

import '../../domain/usecases/get_popular_movies.dart';
import '../../data/repositories/movie_repository_impl.dart';
import '../../data/datasources/movie_remote_datasource.dart';

final dioProvider = Provider((ref) {
  return DioClient().dio;
});

final movieDatasourceProvider = Provider((ref) {
  return MovieRemoteDatasourceImpl(ref.read(dioProvider));
});

final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(ref.read(movieDatasourceProvider));
});

final getPopularMoviesProvider = Provider((ref) {
  return GetMovies(ref.read(movieRepositoryProvider));
});

final popularMoviesProvider = FutureProvider((ref) async {
  final usecase = ref.read(getPopularMoviesProvider);
  return usecase();
});