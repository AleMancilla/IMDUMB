import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imdumb/features/home/presentation/widgets/custom_scaffold.dart';
import 'package:imdumb/features/movies/domain/entities/movie_generes.dart';
import 'package:imdumb/features/movies/presentation/widgets/now_playing_carousel.dart';
import 'package:imdumb/features/movies/presentation/widgets/movie_horizontal_list.dart';
import 'package:imdumb/features/splash/presentation/widgets/animated_letter_text.dart';

import '../../../movies/presentation/providers/movie_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popularMovies = ref.watch(popularMoviesProvider(1));
    final generes = ref.watch(generesMoviesProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider(1));

    return CustomScaffold(
      appBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          spacing: 20,
          children: [
            Expanded(
              child: AnimatedLetterText(
                fontSize: 30,
                text: "IMDUMB",
                onAnimationComplete: () async {
                  await Future.delayed(const Duration(seconds: 1));
                },
              ),
            ),
            Icon(Icons.search, color: Colors.white),
            Icon(Icons.settings, color: Colors.white),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            nowPlayingMovies.when(
              data: (list) => NowPlayingCarousel(movies: list),
              loading: () => const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => SizedBox(
                height: 200,
                child: Center(
                  child: Text(
                    e.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            popularMovies.when(
              data: (movies) => MoviesHorizontalList(
                movies: movies,
                title: 'En Tendencia',
              ),
              loading: () => const SizedBox(
                height: 270,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => Center(
                child: Text(
                  e.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            generes.when(
              data: (genres) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final genre in genres) GenreMovieSection(genre: genre),
                ],
              ),
              loading: () => const SizedBox(
                height: 48,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => SizedBox(
                height: 48,
                child: Center(
                  child: Text(
                    e.toString(),
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class GenreMovieSection extends ConsumerWidget {
  final Genre genre;

  const GenreMovieSection({super.key, required this.genre});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesByGenre = ref.watch(moviesByGenreProvider(genre.id));

    return moviesByGenre.when(
      data: (movies) => MoviesHorizontalList(
        movies: movies,
        title: genre.name,
      ),
      loading: () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                genre.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
            ),
            const SizedBox(
              height: 270,
              child: Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
      error: (e, _) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                genre.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
            ),
            SizedBox(
              height: 80,
              child: Center(
                child: Text(
                  e.toString(),
                  style: const TextStyle(color: Colors.white54),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
