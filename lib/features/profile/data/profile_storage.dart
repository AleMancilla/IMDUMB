import 'package:shared_preferences/shared_preferences.dart';

const String _keyProfileCompleted = 'profile_completed';
const String _keyDisplayName = 'display_name';

abstract final class ProfileStorage {
  static Future<bool> hasCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyProfileCompleted) ?? false;
  }

  static Future<String?> getDisplayName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyDisplayName);
  }

  static Future<void> setDisplayName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyDisplayName, name.trim());
  }

  static Future<void> markCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyProfileCompleted, true);
  }
}
