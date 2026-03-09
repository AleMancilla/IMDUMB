import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Constantes de API leídas desde .env (según ENV: stage o prod).
/// Ejecutar: flutter run --dart-define=ENV=stage | flutter run --dart-define=ENV=prod
class ApiConstants {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';
  static String get baseImageUrl => dotenv.env['BASE_IMAGE_URL'] ?? '';
  static String get baseBackdropUrl => dotenv.env['BASE_BACKDROP_URL'] ?? '';
  static String get apiKey => dotenv.env['API_KEY'] ?? '';

  // Rutas de la API (iguales en stage y prod)
  static const String popularMovies = '/movie/popular';
  static const String movieGeneres = '/genre/movie/list';
  static const String nowPlayingMovies = '/movie/now_playing';
  static const String discoverMovies = '/discover/movie';
  static movieCreditlUrl(int movieId) => '/movie/$movieId/credits';
}
