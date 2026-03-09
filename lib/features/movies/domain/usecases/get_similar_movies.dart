import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetSimilarMovies {
  final MovieRepository repository;

  GetSimilarMovies(this.repository);

  Future<List<Movie>> call(int movieId, {int page = 1}) {
    return repository.getSimilarMovies(movieId, page: page);
  }
}
