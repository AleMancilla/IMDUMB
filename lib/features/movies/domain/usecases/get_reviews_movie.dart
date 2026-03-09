import 'package:imdumb/features/movies/domain/entities/movie_reviews.dart';

import '../repositories/movie_repository.dart';

class GetReviewsMovie {

  final MovieRepository repository;

  GetReviewsMovie(this.repository);

  Future<List<MovieReview>> call(int movieId) {
    return repository.getReviewsMovie(movieId);
  }
}