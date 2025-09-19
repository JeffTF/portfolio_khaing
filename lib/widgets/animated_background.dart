import 'package:flutter/material.dart';
import 'dart:math' as math;

class CirclesPainter extends CustomPainter {
  final Color color;
  final List<Offset> positions = List.generate(5, (_) => Offset.zero);
  final List<double> sizes = List.generate(5, (_) => 0);
  final math.Random random = math.Random(42); // Fixed seed for consistency

  CirclesPainter(this.color) {
    for (int i = 0; i < 5; i++) {
      positions[i] = Offset(
        random.nextDouble() * 0.8 + 0.1, // 10% to 90% of width
        random.nextDouble() * 0.8 + 0.1, // 10% to 90% of height
      );
      sizes[i] =
          random.nextDouble() * 0.2 + 0.1; // 10% to 30% of min(width, height)
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final minDimension = math.min(size.width, size.height);

    for (int i = 0; i < positions.length; i++) {
      final radius = minDimension * sizes[i];
      final position = Offset(
        positions[i].dx * size.width,
        positions[i].dy * size.height,
      );

      canvas.drawCircle(position, radius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class AnimatedBackground extends StatelessWidget {
  final Color color;

  const AnimatedBackground({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: CustomPaint(
        painter: CirclesPainter(color),
      ),
    );
  }
}

