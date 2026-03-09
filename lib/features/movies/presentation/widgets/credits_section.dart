import 'package:flutter/material.dart';
import 'package:imdumb/core/constants/api_constants.dart';
import 'package:imdumb/features/movies/domain/entities/movie_credits.dart';

class CreditsSection extends StatelessWidget {
  final MovieCredits credits;

  const CreditsSection({super.key, required this.credits});

  @override
  Widget build(BuildContext context) {
    final cast = credits.cast ?? [];
    if (cast.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reparto',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: cast.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (_, index) {
                final person = cast[index];
                final profileUrl = person.profilePath != null &&
                        person.profilePath!.isNotEmpty
                    ? '${ApiConstants.baseImageUrl}${person.profilePath}'
                    : null;
                return SizedBox(
                  width: 90,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: profileUrl != null
                            ? Image.network(
                                profileUrl,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) => Image.asset(
                                  'assets/images/imageNotFound.png',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(
                                width: 80,
                                height: 80,
                                color: Colors.grey.shade800,
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white38,
                                  size: 40,
                                ),
                              ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        person.name ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      if (person.character != null &&
                          person.character!.isNotEmpty)
                        Text(
                          person.character!,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 11,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
