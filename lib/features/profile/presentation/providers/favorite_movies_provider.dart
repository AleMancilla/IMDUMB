import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imdumb/features/movies/domain/entities/movie.dart';
import 'package:imdumb/features/movies/domain/entities/movie_details.dart';
import 'package:imdumb/features/movies/presentation/providers/movie_provider.dart';
import 'package:imdumb/features/profile/data/datasources/profile_firebase_datasource.dart';

Movie _detailsToMovie(MovieDetails d) {
  return Movie(
    adult: d.adult ?? false,
    backdropPath: d.backdropPath ?? '',
    genreIds: d.genres?.map((g) => g.id).toList() ?? [],
    id: d.id ?? 0,
    originalLanguage: d.originalLanguage ?? '',
    originalTitle: d.originalTitle ?? '',
    overview: d.overview ?? '',
    popularity: d.popularity ?? 0,
    posterPath: d.posterPath ?? '',
    releaseDate: d.releaseDate ?? DateTime(0),
    title: d.title ?? '',
    video: d.video ?? false,
    voteAverage: d.voteAverage ?? 0,
    voteCount: d.voteCount ?? 0,
  );
}

final favoriteMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final ids = await ProfileFirebaseDatasource.getFavoriteIds();
  if (ids.isEmpty) return [];
  final getDetails = ref.read(getDetailsMovieProvider);
  final list = <Movie>[];
  for (final id in ids) {
    try {
      final details = await getDetails(id);
      list.add(_detailsToMovie(details));
    } catch (_) {
      // Ignorar películas que ya no existan o fallen
    }
  }
  return list;
});
