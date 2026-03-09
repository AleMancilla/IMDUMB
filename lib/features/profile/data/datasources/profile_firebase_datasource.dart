import 'package:firebase_database/firebase_database.dart';
import 'package:imdumb/features/movies/domain/entities/movie.dart';
import 'package:imdumb/features/profile/data/profile_storage.dart';

const String _usersPath = 'users';
const String _favoritesKey = 'favorites';

/// Caracteres no permitidos en keys de Realtime Database: . $ # [ ] / \
String _sanitizeKeyForFirebase(String alias) {
  return alias
      .replaceAll('.', '_')
      .replaceAll('\$', '_')
      .replaceAll('#', '_')
      .replaceAll('[', '_')
      .replaceAll(']', '_')
      .replaceAll('/', '_')
      .replaceAll('\\', '_')
      .trim();
}

abstract final class ProfileFirebaseDatasource {
  static DatabaseReference get _usersRef =>
      FirebaseDatabase.instance.ref(_usersPath);

  static Future<DatabaseReference?> _currentUserRef() async {
    final userId = await ProfileStorage.getFirebaseUserId();
    if (userId == null || userId.isEmpty) return null;
    return _usersRef.child(userId);
  }

  static Future<bool> saveAlias(String alias) async {
    final trimmed = alias.trim();
    if (trimmed.isEmpty) return false;

    final key = _sanitizeKeyForFirebase(trimmed);
    if (key.isEmpty) return false;

    final userRef = _usersRef.child(key);
    final snap = await userRef.get();

    if (snap.exists) {
      // Usuario ya existe
      await ProfileStorage.setFirebaseUserId(key);
      return true;
    }

    await userRef.set({
      'alias': trimmed,
      'createdAt': ServerValue.timestamp,
    });
    await ProfileStorage.setFirebaseUserId(key);
    return false;
  }

  static Future<Set<int>> getFavoriteIds() async {
    final userRef = await _currentUserRef();
    if (userRef == null) return {};
    final snap = await userRef.child(_favoritesKey).get();
    if (!snap.exists || snap.value == null) return {};
    final value = snap.value as Map<Object?, Object?>;
    return value.keys
        .map((e) => int.tryParse(e.toString()))
        .whereType<int>()
        .toSet();
  }

  static Future<void> addFavorite(Movie movie) async {
    final userRef = await _currentUserRef();
    if (userRef == null) return;
    await userRef.child(_favoritesKey).child('${movie.id}').set({
      'id': movie.id,
      'title': movie.title,
      'posterPath': movie.posterPath,
      'backdropPath': movie.backdropPath,
      'overview': movie.overview,
      'releaseDate': movie.releaseDate.toIso8601String(),
      'voteAverage': movie.voteAverage,
      'addedAt': ServerValue.timestamp,
    });
  }

  static Future<void> removeFavorite(int movieId) async {
    final userRef = await _currentUserRef();
    if (userRef == null) return;
    await userRef.child(_favoritesKey).child('$movieId').remove();
  }

  static Future<bool> toggleFavorite(Movie movie) async {
    final ids = await getFavoriteIds();
    if (ids.contains(movie.id)) {
      await removeFavorite(movie.id);
      return false;
    } else {
      await addFavorite(movie);
      return true;
    }
  }
}
