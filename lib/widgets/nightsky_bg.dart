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
  late Animation<double> _blinkAnimation;
  final Random random = Random();
  final int numStars = 150;
  final List<Offset> stars = [];
  final List<double> starSizes = [];
  final List<double> starBlinkOffsets = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _blinkAnimation = Tween<double>(begin: 0.3, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Generate star positions once
    for (int i = 0; i < numStars; i++) {
      final screenWidth =
          MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
      final screenHeight =
          MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;
      stars.add(Offset(random.nextDouble() * screenWidth,
          random.nextDouble() * screenHeight));
      starSizes.add(random.nextDouble() * 1.5 + 0.5);
      starBlinkOffsets.add(random.nextDouble());
      setState(() {});
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
            child: AnimatedBuilder(
                animation: _blinkAnimation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: StarrySkyPainter(
                        starPositions: stars,
                        starSizes: starSizes,
                        blinkValue: _blinkAnimation.value,
                        blinkOffsets: starBlinkOffsets,
                        animationStatus: _controller.status),
                    child: Container(),
                  );
                }),
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
  final double blinkValue;
  final List<double> blinkOffsets;
  final AnimationStatus animationStatus;

  StarrySkyPainter(
      {required this.starPositions,
      required this.starSizes,
      required this.blinkValue,
      required this.blinkOffsets,
      required this.animationStatus});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    //..color = Colors.white.withOpacity(0.8);

    for (int i = 0; i < starPositions.length; i++) {
      final pos = starPositions[i];
      final radius = starSizes[i];
      final offSet = blinkOffsets[i];
      double localBlinkValue = (blinkValue + offSet) % 1.0;
      if (animationStatus == AnimationStatus.reverse) {
        localBlinkValue = (1.0 - (blinkValue + offSet)) % 1.0;
      }
      final double curvedValue = Curves.easeInOut.transform(localBlinkValue);
      final double opacity = 0.3 + (curvedValue * 0.7);
      paint.color = Colors.white.withOpacity(opacity);
      canvas.drawCircle(pos, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant StarrySkyPainter oldDelegate) {
    return oldDelegate.blinkValue != blinkValue ||
        oldDelegate.animationStatus != animationStatus;
  }
}
