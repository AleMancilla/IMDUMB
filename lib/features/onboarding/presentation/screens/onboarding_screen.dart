import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imdumb/core/constants/api_constants.dart';
import 'package:imdumb/features/home/presentation/widgets/custom_scaffold.dart';
import 'package:imdumb/features/movies/domain/entities/movie.dart';
import 'package:imdumb/features/movies/presentation/providers/movie_provider.dart';
import 'package:imdumb/features/onboarding/data/onboarding_storage.dart';
import 'package:imdumb/features/profile/presentation/screens/profile_setup_screen.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late final AnimationController _scrollController;

  /// Tamaño del poster en la primera pantalla (reemplaza al icono).
  static const double _posterWidthFirstPage = 180.0;
  static const double _posterSpacing = 12.0;
  static const int _segmentDurationSeconds = 108;

  static const List<_OnboardingPage> _pages = [
    _OnboardingPage(
      title: 'Descubre nuevas películas',
      body:
          'Explora miles de películas organizadas por categorías\n y encuentra rápidamente algo para ver.',
      icon: Icons.movie_creation_outlined,
    ),
    _OnboardingPage(
      title: 'Explora por categorías',
      body:
          'Accede a tendencias, acción, drama y muchas\n otras categorías en un solo lugar.',
      icon: Icons.category_outlined,
    ),
    _OnboardingPage(
      title: 'Recomienda a tus amigos',
      body:
          'Comparte tu opinión sobre cualquier película\n y recomienda lo mejor a otros usuarios.',
      icon: Icons.thumb_up_outlined,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: _segmentDurationSeconds),
    )..repeat();
  }

  Future<void> _completeOnboarding() async {
    await OnboardingStorage.markCompleted();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ProfileSetupScreen()),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final popularAsync = ref.watch(popularMoviesProvider(1));

    return CustomScaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          page.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 24),
                        if (index == 0) ...[
                          const SizedBox(height: 16),
                          _AnimatedMovieStrip(
                            moviesAsync: popularAsync,
                            animation: _scrollController,
                            posterWidth: _posterWidthFirstPage,
                            posterSpacing: _posterSpacing,
                          ),
                          const SizedBox(height: 40),
                        ] else ...[
                          const SizedBox(height: 24),
                          if (index == 1)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'assets/images/categorias_image.png',
                                width: double.infinity,
                                fit: BoxFit.contain,
                                errorBuilder: (_, _, _) => Icon(
                                  page.icon,
                                  size: 80,
                                  color: Colors.white.withValues(alpha: 0.9),
                                ),
                              ),
                            )
                          else
                            Icon(
                              page.icon,
                              size: 80,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          const SizedBox(height: 48),
                        ],
                        const SizedBox(height: 24),
                  
                        Text(
                          page.body,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _currentPage == _pages.length - 1
                            ? _completeOnboarding
                            : () {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                        borderRadius: BorderRadius.circular(16),
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: _currentPage == _pages.length - 1
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.12),
                            border: Border.all(
                              color: _currentPage == _pages.length - 1
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.35),
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _currentPage == _pages.length - 1
                                      ? 'Comenzar'
                                      : 'Siguiente',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.2,
                                    color: _currentPage == _pages.length - 1
                                        ? const Color(0xFF111827)
                                        : Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  _currentPage == _pages.length - 1
                                      ? Icons.arrow_forward_rounded
                                      : Icons.arrow_forward_rounded,
                                  size: 20,
                                  color: _currentPage == _pages.length - 1
                                      ? const Color(0xFF111827)
                                      : Colors.white.withValues(alpha: 0.9),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage {
  final String title;
  final String body;
  final IconData icon;

  const _OnboardingPage({
    required this.title,
    required this.body,
    required this.icon,
  });
}

class _AnimatedMovieStrip extends StatelessWidget {
  const _AnimatedMovieStrip({
    required this.moviesAsync,
    required this.animation,
    required this.posterWidth,
    required this.posterSpacing,
  });

  final AsyncValue<List<Movie>> moviesAsync;
  final AnimationController animation;
  final double posterWidth;
  final double posterSpacing;

  @override
  Widget build(BuildContext context) {
    return moviesAsync.when(
      data: (movies) {
        if (movies.isEmpty) return const SizedBox.shrink();
        final segmentWidth = movies.length * (posterWidth + posterSpacing);
        return SizedBox(
          height: posterWidth * 1.45,
          child: ClipRect(
            clipBehavior: Clip.hardEdge,
            child: OverflowBox(
              alignment: Alignment.centerLeft,
              maxWidth: double.infinity,
              child: AnimatedBuilder(
                animation: animation,
                builder: (context, _) {
                  final offset = animation.value * segmentWidth;
                  return Transform.translate(
                    offset: Offset(-offset, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [_posterRow(movies), _posterRow(movies)],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
      loading: () => SizedBox(
        height: posterWidth * 1.45,
        child: Center(
          child: SizedBox(
            width: 28,
            height: 28,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white.withValues(alpha: 0.6),
            ),
          ),
        ),
      ),
      error: (_, _) => const SizedBox.shrink(),
    );
  }

  Widget _posterRow(List<Movie> movies) {
    final baseUrl = ApiConstants.baseImageUrl;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: movies.map((movie) {
        final url = movie.posterPath.isNotEmpty
            ? '$baseUrl${movie.posterPath}'
            : null;
        return Container(
          width: posterWidth + posterSpacing,
          padding: EdgeInsets.only(right: posterSpacing),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 2 / 3,
              child: url != null
                  ? Image.network(
                      url,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => _placeholder(),
                    )
                  : _placeholder(),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _placeholder() {
    return Container(
      color: Colors.white.withValues(alpha: 0.1),
      child: Icon(
        Icons.movie_outlined,
        color: Colors.white.withValues(alpha: 0.3),
        size: posterWidth * 0.35,
      ),
    );
  }
}
