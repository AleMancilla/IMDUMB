import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imdumb/features/home/presentation/widgets/custom_scaffold.dart';
import 'package:imdumb/features/splash/presentation/widgets/animated_letter_text.dart';

import '../../../movies/presentation/providers/movie_provider.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(popularMoviesProvider(1));
    final generes = ref.watch(generesMoviesProvider);

    return CustomScaffold(
      appBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
        spacing: 20,
          children: [
          Expanded(child: AnimatedLetterText(
              fontSize: 30,
              text: "IMDUMB",
              onAnimationComplete: () async {
                await Future.delayed(const Duration(seconds: 1));
              },
            ),),
            Icon(Icons.search, color: Colors.white,),
            Icon(Icons.settings, color: Colors.white,),
            
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          generes.when(
            data: (genres) => SizedBox(
              height: 48,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: genres.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (_, index) {
                  final genre = genres[index];
                  return ActionChip(
                    label: Text(
                      genre.name,
                      style: const TextStyle(color: Colors.black),
                    ),
                    backgroundColor: Colors.white24,
                    side: BorderSide.none,
                    onPressed: () {},
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
                child: Text(e.toString(), style: const TextStyle(color: Colors.red)),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: movies.when(
              data: (movies) {
                return ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (_, index) {
                    final movie = movies[index];
                    return ListTile(
                      title: Text(
                        movie.title,
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text(e.toString())),
            ),
          ),
        ],
      ),
    );
  }
}
