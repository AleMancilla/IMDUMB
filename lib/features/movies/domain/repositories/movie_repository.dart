import 'package:imdumb/features/movies/domain/entities/movie_generes.dart';
import 'package:imdumb/features/movies/domain/entities/movie_now_playing.dart';

import '../entities/movie.dart';

abstract class MovieRepository {

  Future<List<Movie>> getPopularMovies({int page = 1});
  Future<List<Genre>> getMovieGeneres();
  Future<List<MovieNowPlaying>> getNowPlayingMovies({int page = 1});
}