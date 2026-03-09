import 'package:imdumb/features/movies/data/models/movie_credits_model.dart';
import 'package:imdumb/features/movies/data/models/movie_details_model.dart';
import 'package:imdumb/features/movies/data/models/movie_generes_model.dart';
import 'package:imdumb/features/movies/data/models/movie_reviews_model.dart';
import 'package:imdumb/features/movies/data/models/movie_model.dart';

abstract class MovieLocalDatasource {
  Future<List<MovieModel>?> getPopularMovies(int page);
  Future<void> savePopularMovies(int page, List<MovieModel> movies);

  Future<List<GenreModel>?> getMovieGenres();
  Future<void> saveMovieGenres(List<GenreModel> genres);

  Future<List<MovieModel>?> getNowPlayingMovies(int page);
  Future<void> saveNowPlayingMovies(int page, List<MovieModel> movies);

  Future<List<MovieModel>?> getMoviesByGenre(int genreId, int page);
  Future<void> saveMoviesByGenre(int genreId, int page, List<MovieModel> movies);

  Future<MovieCreditsModel?> getCreditsMovie(int movieId);
  Future<void> saveCreditsMovie(int movieId, MovieCreditsModel credits);

  Future<MovieDetailsModel?> getDetailsMovie(int movieId);
  Future<void> saveDetailsMovie(int movieId, MovieDetailsModel details);

  Future<List<MovieModel>?> getSimilarMovies(int movieId, int page);
  Future<void> saveSimilarMovies(int movieId, int page, List<MovieModel> movies);

  Future<List<MovieReviewModel>?> getReviewsMovie(int movieId);
  Future<void> saveReviewsMovie(int movieId, List<MovieReviewModel> reviews);
}
