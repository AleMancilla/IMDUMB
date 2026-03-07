import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imdumb/features/splash/presentation/providers/splash_controller.dart';
import 'package:imdumb/features/splash/presentation/providers/splash_state.dart';
import 'package:imdumb/home_screen.dart';


class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(splashProvider.notifier).initializeApp();
    });
  }

  @override
  Widget build(BuildContext context) {

    ref.listen<SplashState>(splashProvider, (previous, next) {
      if (next == SplashState.ready) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        );
      }
    });

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}