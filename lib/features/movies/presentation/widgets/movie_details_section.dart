import 'package:flutter/material.dart';
import 'package:imdumb/features/movies/domain/entities/movie_details.dart';
import 'package:imdumb/features/movies/presentation/widgets/detail_chip.dart';

class MovieDetailsSection extends StatelessWidget {
  final MovieDetails details;

  const MovieDetailsSection({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    final hasTagline = details.tagline != null && details.tagline!.isNotEmpty;
    final hasRuntime = details.runtime != null && details.runtime! > 0;
    final hasGenres = details.genres != null && details.genres!.isNotEmpty;
    final hasStatus = details.status != null && details.status!.isNotEmpty;

    if (!hasTagline && !hasRuntime && !hasGenres && !hasStatus) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasTagline) ...[
            Text(
              details.tagline!,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 15,
                fontStyle: FontStyle.italic,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
          ],
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (hasRuntime)
                DetailChip(
                  icon: Icons.schedule,
                  label: '${details.runtime} min',
                ),
              if (hasStatus)
                DetailChip(icon: Icons.info_outline, label: details.status!),
            ],
          ),
          if (hasGenres) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: details.genres!
                  .map(
                    (g) => Chip(
                      label: Text(
                        g.name,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      backgroundColor: Colors.white24,
                      side: BorderSide.none,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}
