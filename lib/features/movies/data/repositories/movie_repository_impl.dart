import 'package:imdumb/features/movies/domain/entities/movie_generes.dart';
import 'package:imdumb/features/movies/domain/entities/movie_now_playing.dart';

import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_remote_datasource.dart';
import '../mappers/movie_generes_mapper.dart';
import '../mappers/movie_mapper.dart';
import '../mappers/movie_now_playing_mapper.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDatasource remoteDatasource;

  MovieRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<MoviePopular>> getPopularMovies({int page = 1}) async {
    final movies = await remoteDatasource.getPopularMovies(page: page);

    return movies.map((movie) => movie.toEntity()).toList();
  }

  @override
  Future<List<Genre>> getMovieGeneres() async {
    final genres = await remoteDatasource.getMovieGeneres();

    return genres.map((genre) => genre.toEntity()).toList();
  }

  @override
  Future<List<MovieNowPlaying>> getNowPlayingMovies({int page = 1}) async {
    final moviesNowPlaying = await remoteDatasource.getNowPlayingMovies(
      page: page,
    );

    return moviesNowPlaying.map((movie) => movie.toEntity()).toList();
  }
}
