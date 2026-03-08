import 'package:flutter/material.dart';

class PulseBackground extends StatefulWidget {
  final int waves;
  final Duration duration;
  final Color color;
  final double maxRadius;

  const PulseBackground({
    super.key,
    this.waves = 4,
    this.duration = const Duration(seconds: 4),
    this.color = const Color(0xFF3B82F6),
    this.maxRadius = 0.75,
  });

  @override
  State<PulseBackground> createState() => _PulseBackgroundState();
}


class _PulseBackgroundState extends State<PulseBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: controller,
        builder: (_, _) {
          return CustomPaint(
            painter: _PulsePainter(
              progress: controller.value,
              waves: widget.waves,
              color: widget.color,
              maxRadiusFactor: widget.maxRadius,
            ),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class _PulsePainter extends CustomPainter {
  final double progress;
  final int waves;
  final Color color;
  final double maxRadiusFactor;

  _PulsePainter({
    required this.progress,
    required this.waves,
    required this.color,
    required this.maxRadiusFactor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);

    final maxRadius = size.width * maxRadiusFactor;

    for (int i = 0; i < waves; i++) {
      final delay = i / waves;

      double waveProgress = (progress - delay) % 1;

      if (waveProgress < 0) {
        waveProgress += 1;
      }

      final radius = maxRadius * waveProgress;

      final opacity = (1 - waveProgress).clamp(0.0, 1.0);

      final paint = Paint()
        ..color = color.withValues(alpha: opacity * 0.15)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _PulsePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
