import 'package:imdumb/features/movies/domain/entities/movie_credits.dart';
import 'package:imdumb/features/movies/domain/entities/movie_details.dart';
import 'package:imdumb/features/movies/domain/entities/movie_generes.dart';

import '../entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getPopularMovies({int page = 1});
  Future<List<Genre>> getMovieGeneres();
  Future<List<Movie>> getNowPlayingMovies({int page = 1});
  Future<List<Movie>> getMoviesByGenre(int genreId, {int page = 1});
  Future<MovieCredits> getCreditsMovie(int movieId);
  Future<MovieDetails> getDetailsMovie(int movieId);
}