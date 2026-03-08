import 'package:flutter/material.dart';
import 'package:imdumb/features/splash/presentation/screens/splash_screen.dart';

class AnimatedWelcomeMessage extends StatefulWidget {
  final String message;

  const AnimatedWelcomeMessage({required this.message});

  @override
  State<AnimatedWelcomeMessage> createState() =>
      _AnimatedWelcomeMessageState();
}


class _AnimatedWelcomeMessageState extends State<AnimatedWelcomeMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: Text(
            widget.message,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
      ),
    );
  }
}
