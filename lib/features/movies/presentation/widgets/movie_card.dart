import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:imdumb/core/constants/api_constants.dart';
import 'package:imdumb/features/movies/domain/entities/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final rating = movie.voteAverage;

    return RepaintBoundary(
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xff0f172a),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .4),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              child: Image.network(
                "${ApiConstants.baseImageUrl}${movie.posterPath}",
                height: 230,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1, sigmaY: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color.fromARGB(
                            255,
                            49,
                            43,
                            43,
                          ).withValues(alpha: 0.2),
                          Colors.white.withValues(alpha: 0.08),
                          Colors.black.withValues(alpha: 0.4),
                        ],
                      ),
                      border: Border(
                        top: BorderSide(
                          color: const Color.fromARGB(
                            255,
                            124,
                            114,
                            114,
                          ).withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    child: Column(
                      spacing: 2,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),

                        Row(
                          spacing: 4,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: _ratingColor(
                                  rating,
                                ).withValues(alpha: .15),
                              ),
                              child: Row(
                                spacing: 4,
                                children: [
                                  Icon(
                                    Icons.thumb_up,
                                    size: 12,
                                    color: _ratingColor(rating),
                                  ),
                                  Text(
                                    rating.toStringAsFixed(1),
                                    style: TextStyle(
                                      fontFamily: 'Junegull',
                                      fontSize: 12,
                                      color: _ratingColor(rating),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: rating / 10,
                                  minHeight: 6,
                                  backgroundColor: Colors.grey.shade800,
                                  valueColor: AlwaysStoppedAnimation(
                                    _ratingColor(rating),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _ratingColor(double rating) {
    if (rating >= 7.5) return Colors.green;
    if (rating >= 6) return Colors.orange;
    return Colors.red;
  }
}
