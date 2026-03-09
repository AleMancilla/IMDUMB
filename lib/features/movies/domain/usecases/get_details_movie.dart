import 'package:imdumb/features/movies/domain/entities/movie_details.dart';

import '../repositories/movie_repository.dart';

class GetDetailsMovie {

  final MovieRepository repository;

  GetDetailsMovie(this.repository);

  Future<MovieDetails> call(int movieId) {
    return repository.getDetailsMovie(movieId);
  }
}