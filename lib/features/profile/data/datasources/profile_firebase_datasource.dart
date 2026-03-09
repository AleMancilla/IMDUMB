import 'package:firebase_database/firebase_database.dart';
import 'package:imdumb/features/profile/data/profile_storage.dart';

/// Ruta en Realtime Database donde se guardan los perfiles de usuario.
const String _usersPath = 'users';

abstract final class ProfileFirebaseDatasource {
  static DatabaseReference get _usersRef =>
      FirebaseDatabase.instance.ref(_usersPath);

  static Future<void> saveAlias(String alias) async {
    final trimmed = alias.trim();
    if (trimmed.isEmpty) return;

    final existingId = await ProfileStorage.getFirebaseUserId();

    if (existingId != null && existingId.isNotEmpty) {
      await _usersRef.child(existingId).update({'alias': trimmed});
      return;
    }

    final newRef = _usersRef.push();
    await newRef.set({
      'alias': trimmed,
      'createdAt': ServerValue.timestamp,
    });
    final key = newRef.key;
    if (key != null) {
      await ProfileStorage.setFirebaseUserId(key);
    }
  }
}
