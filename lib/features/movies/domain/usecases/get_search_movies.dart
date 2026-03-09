import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetSearchMovies {
  final MovieRepository repository;

  GetSearchMovies(this.repository);

  Future<List<Movie>> call(String query, {int page = 1}) {
    return repository.searchMovies(query, page: page);
  }
}
