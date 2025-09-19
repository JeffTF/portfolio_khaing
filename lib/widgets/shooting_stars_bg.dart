import 'package:flutter/material.dart';
import 'dart:math' as math;

class ShootingStar {
  Offset position;
  double angle;
  double speed;
  double length;
  double opacity;

  ShootingStar(
      this.position, this.angle, this.speed, this.length, this.opacity);
}

class ShootingStarsPainter extends CustomPainter {
  final List<ShootingStar> stars;

  ShootingStarsPainter(this.stars);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    for (final star in stars) {
      paint.shader = LinearGradient(
        colors: [
          Colors.white.withOpacity(star.opacity),
          Colors.purpleAccent.withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(
        star.position.dx,
        star.position.dy,
        star.length,
        star.length,
      ));

      final end = Offset(
        star.position.dx - math.cos(star.angle) * star.length,
        star.position.dy - math.sin(star.angle) * star.length,
      );

      canvas.drawLine(star.position, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ShootingStarsBackground extends StatefulWidget {
  const ShootingStarsBackground({super.key});

  @override
  State<ShootingStarsBackground> createState() =>
      _ShootingStarsBackgroundState();
}

class _ShootingStarsBackgroundState extends State<ShootingStarsBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<ShootingStar> stars = [];
  final math.Random random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..addListener(_updateStars)
          ..repeat();
  }

  void _updateStars() {
    setState(() {
      // Occasionally add a new star
      if (random.nextDouble() < 0.04) {
        stars.add(
          ShootingStar(
            Offset(random.nextDouble() * MediaQuery.of(context).size.width, 0),
            math.pi / 4, // 45° diagonal angle
            // random.nextDouble() * 6 + 4,
            // random.nextDouble() * 60 + 40,
            // random.nextDouble() * (math.pi / 3) +
            //     math.pi / 6, // random angle between 30°–60°
            random.nextDouble() * 8 + 6, // faster speed: 6–14
            random.nextDouble() * 60 + 50, // longer streaks
            1.0,
          ),
        );
      }

      // Update positions
      stars.removeWhere((star) => star.opacity <= 0);
      for (final star in stars) {
        star.position = Offset(
          star.position.dx + math.cos(star.angle) * star.speed,
          star.position.dy + math.sin(star.angle) * star.speed,
        );
        star.opacity -= 0.02;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: CustomPaint(
        painter: ShootingStarsPainter(stars),
      ),
    );
  }
}
