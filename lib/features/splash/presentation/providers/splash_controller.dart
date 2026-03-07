import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/services/remote_config_service.dart';
import 'splash_state.dart';

final splashProvider =
    StateNotifierProvider<SplashController, SplashState>((ref) {
  return SplashController();
});

class SplashController extends StateNotifier<SplashState> {
  SplashController() : super(SplashState.loading);

  Future<void> initializeApp() async {
    try {
      final remoteConfigService = RemoteConfigService();
      await remoteConfigService.init();
      final message = remoteConfigService.getWelcomeMessage();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("welcome_message", message);
      state = SplashState.ready;
    } catch (e) {
      state = SplashState.error;
    }
  }
}