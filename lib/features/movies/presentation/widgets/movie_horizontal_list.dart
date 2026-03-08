import 'package:flutter/material.dart';
import 'package:imdumb/features/movies/domain/entities/movie.dart';
import 'package:imdumb/features/movies/presentation/widgets/movie_card.dart';
class MoviesHorizontalList extends StatelessWidget {
  final List<Movie> movies;

  const MoviesHorizontalList({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: movies.length,
        itemBuilder: (_, i) {
          return MovieCard(movie: movies[i]);
        },
      ),
    );
  }
}