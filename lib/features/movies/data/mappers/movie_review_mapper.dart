import 'package:imdumb/features/movies/data/models/movie_reviews_model.dart';
import 'package:imdumb/features/movies/domain/entities/movie_reviews.dart';

extension AuthorDetailsMapper on AuthorDetailsModel {
  AuthorDetails toEntity() {
    return AuthorDetails(
      name: name,
      username: username,
      avatarPath: avatarPath,
      rating: rating,
    );
  }
}

extension MovieReviewMapper on MovieReviewModel {
  MovieReview toEntity() {
    return MovieReview(
      author: author,
      authorDetails: authorDetails?.toEntity(),
      content: content,
      createdAt: createdAt,
      id: id,
      updatedAt: updatedAt,
      url: url,
    );
  }
}

extension MovieReviewsPageMapper on MovieReviewsPageModel {
  MovieReviewsPage toEntity() {
    return MovieReviewsPage(
      id: id,
      page: page,
      results: results?.map((r) => r.toEntity()).toList(),
      totalPages: totalPages,
      totalResults: totalResults,
    );
  }
}
