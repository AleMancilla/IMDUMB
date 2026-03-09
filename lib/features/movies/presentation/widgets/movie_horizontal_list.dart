import 'package:flutter/material.dart';
import 'package:imdumb/features/movies/domain/entities/movie.dart';
import 'package:imdumb/features/movies/presentation/screens/movie_detail_screen.dart';
import 'package:imdumb/features/movies/presentation/widgets/movie_card.dart';
class MoviesHorizontalList extends StatelessWidget {
  final List<Movie> movies;
  final String title;

  const MoviesHorizontalList({
    super.key,
    required this.movies,
    this.title = 'En Tendencia',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 270,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: movies.length,
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
                child: MovieCard(movie: movie),
              );
            },
          ),
        ),
      ],
    );
  }
}