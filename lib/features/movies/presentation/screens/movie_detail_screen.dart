import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imdumb/features/movies/presentation/widgets/similar_movies_error.dart';
import 'package:imdumb/features/movies/presentation/widgets/reviews_section.dart';
import 'package:imdumb/features/movies/presentation/widgets/credits_section.dart';
import 'package:imdumb/features/movies/presentation/widgets/movie_details_section.dart';
import 'package:imdumb/features/movies/presentation/widgets/action_chip.dart';
import 'package:share_plus/share_plus.dart';
import 'package:imdumb/core/constants/api_constants.dart';
import 'package:imdumb/features/movies/domain/entities/movie.dart';
import 'package:imdumb/features/movies/presentation/providers/movie_provider.dart';
import 'package:imdumb/features/movies/presentation/widgets/movie_horizontal_list.dart';
import 'package:imdumb/features/profile/data/datasources/profile_firebase_datasource.dart';
import 'package:imdumb/features/profile/presentation/providers/favorite_movies_provider.dart';
import 'package:imdumb/features/profile/presentation/providers/favorites_provider.dart';

class MovieDetailScreen extends ConsumerWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  Future<void> _toggleFavorite(WidgetRef ref) async {
    await ProfileFirebaseDatasource.toggleFavorite(movie);
    ref.invalidate(favoriteIdsProvider);
    ref.invalidate(favoriteMoviesProvider);
  }

  void _shareMovie() {
    final text = movie.overview.isNotEmpty
        ? '${movie.title} (${movie.releaseDate.year})\n\n${movie.overview}'
        : '${movie.title} (${movie.releaseDate.year})';
    SharePlus.instance.share(ShareParams(subject: movie.title, text: text));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final creditsAsync = ref.watch(movieCreditsProvider(movie.id));
    final detailsAsync = ref.watch(movieDetailsProvider(movie.id));
    final similarMoviesAsync = ref.watch(similarMoviesProvider(movie.id));
    final reviewsAsync = ref.watch(movieReviewsProvider(movie.id));
    final favoriteIdsAsync = ref.watch(favoriteIdsProvider);
    final isFavorite = favoriteIdsAsync.value?.contains(movie.id) ?? false;
    final backdropUrl = movie.backdropPath.isNotEmpty
        ? '${ApiConstants.baseBackdropUrl}${movie.backdropPath}'
        : null;
    final posterUrl = movie.posterPath.isNotEmpty
        ? '${ApiConstants.baseImageUrl}${movie.posterPath}'
        : null;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                radius: 1.2,
                colors: [Color(0xFF111827), Color(0xFF030712)],
              ),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 220,
                pinned: true,
                backgroundColor: Colors.black54,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: backdropUrl != null
                      ? Image.network(
                          backdropUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Image.asset(
                            'assets/images/imageNotFound.png',
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          color: Colors.grey.shade900,
                          child: const Icon(
                            Icons.movie,
                            size: 64,
                            color: Colors.white24,
                          ),
                        ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (posterUrl != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                posterUrl,
                                width: 120,
                                height: 180,
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) => Image.asset(
                                  'assets/images/imageNotFound.png',
                                  width: 120,
                                  height: 180,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          else
                            Container(
                              width: 120,
                              height: 180,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade800,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.movie,
                                color: Colors.white24,
                                size: 48,
                              ),
                            ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (movie.originalTitle != movie.title)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      movie.originalTitle,
                                      style: TextStyle(
                                        color: Colors.white.withValues(
                                          alpha: 0.7,
                                        ),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 12),
                                Text(
                                  _formatDate(movie.releaseDate),
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: _ratingColor(movie.voteAverage),
                                      size: 20,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${movie.voteAverage.toStringAsFixed(1)} / 10',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Junegull',
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  spacing: 10,
                                  children: [
                                    CustomActionChip(
                                      icon: isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      label: isFavorite
                                          ? 'En favoritos'
                                          : 'Favorito',
                                      color: isFavorite
                                          ? Colors.red
                                          : Colors.white.withValues(alpha: 0.9),
                                      onPressed: favoriteIdsAsync.isLoading
                                          ? null
                                          : () => _toggleFavorite(ref),
                                    ),
                                    CustomActionChip(
                                      icon: Icons.share_outlined,
                                      label: 'Compartir',
                                      color: Colors.white.withValues(
                                        alpha: 0.9,
                                      ),
                                      onPressed: _shareMovie,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (movie.overview.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        Text(
                          'Sinopsis',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          movie.overview,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                      ],
                      detailsAsync.when(
                        data: (details) =>
                            MovieDetailsSection(details: details),
                        loading: () => const Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Center(
                            child: SizedBox(
                              width: 28,
                              height: 28,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                        ),
                        error: (_, _) => const SizedBox.shrink(),
                      ),
                      creditsAsync.when(
                        data: (credits) => CreditsSection(credits: credits),
                        loading: () => const Padding(
                          padding: EdgeInsets.only(top: 24),
                          child: Center(
                            child: SizedBox(
                              width: 32,
                              height: 32,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                        ),
                        error: (e, _) => const SizedBox.shrink(),
                      ),
                      similarMoviesAsync.when(
                        data: (similarMovies) => similarMovies.isEmpty
                            ? const SizedBox.shrink()
                            : Padding(
                                padding: const EdgeInsets.only(top: 24),
                                child: MoviesHorizontalList(
                                  movies: similarMovies,
                                  title: 'Películas similares',
                                ),
                              ),
                        loading: () => const Padding(
                          padding: EdgeInsets.only(top: 24),
                          child: Center(
                            child: SizedBox(
                              width: 32,
                              height: 32,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                        ),
                        error: (e, stack) => Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: SimilarMoviesError(
                            error: e,
                            onRetry: () =>
                                ref.invalidate(similarMoviesProvider(movie.id)),
                          ),
                        ),
                      ),
                      reviewsAsync.when(
                        data: (reviews) => ReviewsSection(reviews: reviews),
                        loading: () => const Padding(
                          padding: EdgeInsets.only(top: 24),
                          child: Center(
                            child: SizedBox(
                              width: 28,
                              height: 28,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                        ),
                        error: (_, _) => const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Color _ratingColor(double rating) {
    if (rating >= 7.5) return Colors.green;
    if (rating >= 6) return Colors.orange;
    return Colors.red;
  }
}
