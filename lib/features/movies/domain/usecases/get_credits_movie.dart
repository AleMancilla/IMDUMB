import 'package:imdumb/features/movies/domain/entities/movie_credits.dart';

import '../repositories/movie_repository.dart';

class GetCreditsMovie {

  final MovieRepository repository;

  GetCreditsMovie(this.repository);

  Future<MovieCredits> call(int movieId) {
    return repository.getCreditsMovie(movieId);
  }
}