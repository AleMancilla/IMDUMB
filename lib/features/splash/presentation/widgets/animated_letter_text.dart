import 'package:flutter/material.dart';

class AnimatedLetterText extends StatefulWidget {
  final String text;
  final VoidCallback? onAnimationComplete;

  const AnimatedLetterText({
    super.key,
    required this.text,
    this.onAnimationComplete,
  });

  @override
  State<AnimatedLetterText> createState() => _AnimatedLetterTextState();
}


class _AnimatedLetterTextState extends State<AnimatedLetterText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _controller.forward().then((_) {
      if (mounted) widget.onAnimationComplete?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    final letters = widget.text.split('');
    final letterCount = letters.length;

    const letterAnimationDuration = 0.4;
    const overlap = 0.3;

    final step = letterAnimationDuration * overlap;
    final totalAnimation = step * (letterCount - 1) + letterAnimationDuration;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(letterCount, (index) {
        final start = (step * index) / totalAnimation;
        final end = (start + letterAnimationDuration / totalAnimation).clamp(
          0.0,
          1.0,
        );

        final animation = CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeOutBack),
        );

        final slideAnimation = Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(animation);

        final textColor = index < 2 ? Colors.orange : Colors.white;

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: slideAnimation,
            child: Text(
              letters[index],
              style: TextStyle(
                fontSize: 80,
                fontFamily: 'Junegull',
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
