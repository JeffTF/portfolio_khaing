import 'dart:math';
import 'package:flutter/material.dart';
import 'package:portfolio_khaing/widgets/shooting_stars_bg.dart';

class StarryNightScreen extends StatefulWidget {
  const StarryNightScreen({super.key});

  @override
  State<StarryNightScreen> createState() => _StarryNightScreenState();
}

class _StarryNightScreenState extends State<StarryNightScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random random = Random();
  final int numStars = 150;
  final List<Offset> stars = [];
  final List<double> starSizes = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    // Generate star positions once
    for (int i = 0; i < numStars; i++) {
      stars.add(Offset(
          random.nextDouble() *
              MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .size
                  .width,
          random.nextDouble() *
              MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .size
                  .height));
      starSizes.add(random.nextDouble() * 1.5 + 0.5);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient night sky with stars
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.indigo.shade900,
                  Colors.lightBlue.shade700
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: CustomPaint(
              painter:
                  StarrySkyPainter(starPositions: stars, starSizes: starSizes),
              child: Container(),
            ),
          ),
          ShootingStarsBackground()
        ],
      ),
    );
  }
}

class StarrySkyPainter extends CustomPainter {
  final List<Offset> starPositions;
  final List<double> starSizes;

  StarrySkyPainter({required this.starPositions, required this.starSizes});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.8);

    for (int i = 0; i < starPositions.length; i++) {
      final pos = starPositions[i];
      final radius = starSizes[i];
      canvas.drawCircle(pos, radius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
