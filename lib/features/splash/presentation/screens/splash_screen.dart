import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imdumb/features/movies/presentation/screens/home_page.dart';
import 'package:imdumb/features/splash/presentation/providers/splash_controller.dart';
import 'package:imdumb/features/splash/presentation/providers/splash_state.dart';
import 'package:imdumb/features/splash/presentation/widgets/animated_welcome_message.dart';
import 'package:imdumb/features/splash/presentation/widgets/animated_letter_text.dart';
import 'package:imdumb/features/splash/presentation/widgets/pulse_background.dart';
import 'package:imdumb/home_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool _animationComplete = false;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(splashProvider.notifier).initializeApp();
    });
  }

  void _navigateIfReady() {
    if (!mounted) return;
    final splashState = ref.read(splashProvider);
    if (_animationComplete && splashState is SplashReady) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<SplashState>(splashProvider, (previous, next) {
      if (next is SplashReady) _navigateIfReady();
    });

    final splashState = ref.watch(splashProvider);
    final welcomeMessage = splashState is SplashReady
        ? splashState.welcomeMessage
        : null;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                radius: 1.2,
                colors: [Color(0xFF111827), Color(0xFF030712)],
              ),
            ),
          ),

          PulseBackground(),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedLetterText(
                  text: "IMDUMB",
                  onAnimationComplete: () async {
                    await Future.delayed(const Duration(seconds: 1));
                    setState(() => _animationComplete = true);
                    _navigateIfReady();
                  },
                ),
                if (welcomeMessage != null)
                  Transform.translate(
                    offset: const Offset(0, -20), // x, y
                    child: AnimatedWelcomeMessage(message: welcomeMessage),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
