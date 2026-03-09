import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imdumb/features/home/presentation/widgets/custom_scaffold.dart';
import 'package:imdumb/features/movies/domain/entities/movie.dart';
import 'package:imdumb/features/movies/presentation/screens/movie_detail_screen.dart';
import 'package:imdumb/features/movies/presentation/widgets/search_movie_card.dart';
import 'package:imdumb/features/profile/presentation/providers/favorite_movies_provider.dart';

class FavoritesScreen extends ConsumerStatefulWidget {
  const FavoritesScreen({super.key});

  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(favoriteMoviesProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoritesAsync = ref.watch(favoriteMoviesProvider);

    return CustomScaffold(
      appBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            const SizedBox(width: 8),
            const Text(
              'Favoritos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: favoritesAsync.when(
        data: (movies) => _buildList(context, movies),
        loading: () => const Center(
          child: SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'No se pudieron cargar los favoritos.',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.8)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildList(BuildContext context, List<Movie> movies) {
    if (movies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 64,
              color: Colors.white.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'Aún no tienes favoritos',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Añade películas desde su detalle',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: movies.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, i) {
        final movie = movies[i];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => MovieDetailScreen(movie: movie),
              ),
            );
          },
          child: SearchMovieCard(movie: movie),
        );
      },
    );
  }
}
