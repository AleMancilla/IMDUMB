import 'package:imdumb/features/movies/domain/entities/movie_generes.dart';
import '../repositories/movie_repository.dart';

class GetGeneresMovies {

  final MovieRepository repository;

  GetGeneresMovies(this.repository);

  Future<List<Genre>> call() {
    return repository.getMovieGeneres();
  }
}