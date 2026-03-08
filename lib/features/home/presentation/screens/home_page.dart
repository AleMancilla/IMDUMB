import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imdumb/features/home/presentation/widgets/custom_scaffold.dart';
import 'package:imdumb/features/movies/presentation/widgets/now_playing_carousel.dart';
import 'package:imdumb/features/movies/presentation/widgets/movie_horizontal_list.dart';
import 'package:imdumb/features/splash/presentation/widgets/animated_letter_text.dart';

import '../../../movies/presentation/providers/movie_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGenreId = ref.watch(selectedGenreIdProvider);
    final popularMovies = ref.watch(popularMoviesProvider(1));
    final moviesByGenre = selectedGenreId != null
        ? ref.watch(moviesByGenreProvider(selectedGenreId))
        : null;
    final generes = ref.watch(generesMoviesProvider);
    final selectedGenreName = generes.whenOrNull(
      data: (genres) => genres
          .where((g) => g.id == selectedGenreId)
          .map((g) => g.name)
          .firstOrNull,
    );
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
            generes.when(
              data: (genres) => SizedBox(
                height: 48,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemCount: genres.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (_, index) {
                    final genre = genres[index];
                    final isSelected = selectedGenreId == genre.id;
                    return ActionChip(
                      color: Colors.transparent,
                      label: Text(
                        genre.name,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                      backgroundColor: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.white24.withOpacity(0.4),
                      side: BorderSide.none,
                      onPressed: () {
                        ref
                            .read(selectedGenreIdProvider.notifier)
                            .update(
                              (current) =>
                                  current == genre.id ? null : genre.id,
                            );
                      },
                    );
                  },
                ),
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
            if (selectedGenreId != null && moviesByGenre != null)
              moviesByGenre.when(
                data: (movies) => MoviesHorizontalList(
                  movies: movies,
                  title: selectedGenreName ?? 'Por género',
                ),
                loading: () => const SizedBox(
                  height: 270,
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (e, _) => SizedBox(
                  height: 80,
                  child: Center(
                    child: Text(
                      e.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            popularMovies.when(
              data: (movies) =>
                  MoviesHorizontalList(movies: movies, title: 'En Tendencia'),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text(e.toString())),
            ),
          ],
        ),
      ),
    );
  }
}
