import 'package:shared_preferences/shared_preferences.dart';

const String _keyOnboardingCompleted = 'onboarding_completed';

abstract final class OnboardingStorage {
  static Future<bool> hasCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyOnboardingCompleted) ?? false;
  }

  static Future<void> markCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyOnboardingCompleted, true);
  }
}
