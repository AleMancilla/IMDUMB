import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/movie_provider.dart';

class HomePage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final movies = ref.watch(popularMoviesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Movies")),
      body: movies.when(
        data: (movies) {
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (_, index) {

              final movie = movies[index];

              return ListTile(
                title: Text(movie.title),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }
}