import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedCirclesPainter extends CustomPainter {
  final List<Offset> positions;
  final List<double> sizes;
  final double animationValue;

  AnimatedCirclesPainter(this.positions, this.sizes, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final minDimension = math.min(size.width, size.height);

    for (int i = 0; i < positions.length; i++) {
      final radius =
          minDimension * sizes[i] * (1 + 0.05 * math.sin(animationValue + i));
      final position = Offset(
        positions[i].dx * size.width + 20 * math.sin(animationValue + i),
        positions[i].dy * size.height + 20 * math.cos(animationValue + i),
      );

      final paint = Paint()
        ..shader = RadialGradient(
          colors: [
            Colors.blue.withOpacity(0.25),
            Colors.purple.withOpacity(0.15),
          ],
        ).createShader(Rect.fromCircle(center: position, radius: radius));

      canvas.drawCircle(position, radius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class AnimatedBackgroundV2 extends StatefulWidget {
  const AnimatedBackgroundV2({super.key});

  @override
  State<AnimatedBackgroundV2> createState() => _AnimatedBackgroundV2State();
}

class _AnimatedBackgroundV2State extends State<AnimatedBackgroundV2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Offset> positions = List.generate(
      6, (_) => Offset(math.Random().nextDouble(), math.Random().nextDouble()));
  final List<double> sizes =
      List.generate(6, (_) => math.Random().nextDouble() * 0.2 + 0.1);

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            painter: AnimatedCirclesPainter(
                positions, sizes, _controller.value * 2 * math.pi),
          );
        },
      ),
    );
  }
}
