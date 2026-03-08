import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetMoviesByGenre {
  final MovieRepository repository;

  GetMoviesByGenre(this.repository);

  Future<List<Movie>> call({required int genreId, int page = 1}) {
    return repository.getMoviesByGenre(genreId, page: page);
  }
}
