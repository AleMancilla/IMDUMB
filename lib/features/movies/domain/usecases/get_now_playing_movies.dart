import 'package:imdumb/features/movies/domain/entities/movie.dart';

import '../repositories/movie_repository.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<List<Movie>> call({int page = 1}) {
    return repository.getNowPlayingMovies(page: page);
  }
}