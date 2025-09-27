import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

// The main widget for the rainy window effect
class RainyWindow extends StatefulWidget {
  const RainyWindow({super.key});

  @override
  State<RainyWindow> createState() => _RainyWindowState();
}

class _RainyWindowState extends State<RainyWindow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15), // Controls the speed of the rain
    )..repeat(); // Loop the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // --- 1. The Dark, Stormy Sky Background ---
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey.shade100,
                Colors.blueGrey,
                // const Color(0xFF5CA9FA).withOpacity(
                //     0.2), // Darker version of your primary theme color
                // const Color(0xFF0d47a1), // A deep blue
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        // --- 2. The Raindrops and Streaks ---
        // We use a ClipRect to ensure the painter doesn't draw outside its bounds.
        ClipRect(
          child: CustomPaint(
            // The painter is driven by the animation controller
            painter: RainPainter(animation: _controller),
            child: Container(),
          ),
        ),

        // --- 3. The "Glass" Effect (Blur) ---
        // This blurs everything behind it, giving a frosted glass look.
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: Container(
            color: Colors.black
                .withOpacity(0.1), // A slight dark tint for the glass
          ),
        ),
      ],
    );
  }
}

// The CustomPainter that draws all the rain elements
class RainPainter extends CustomPainter {
  final Animation<double> animation;
  // Generate a list of 200 random raindrop data points
  final List<_Raindrop> raindrops = List.generate(200, (index) => _Raindrop());

  RainPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    // Paint for the standard raindrops
    // Color(0xFF5CA9FA).withOpacity(0.0);
    // Colors.purpleAccent.withOpacity(0.0);
    final dropPaint = Paint()..color = Colors.white.withOpacity(0.5);
    // Paint for the longer streaks, which are fainter
    final streakPaint = Paint()..color = Colors.white.withOpacity(0.2);

    for (final drop in raindrops) {
      // Calculate the current Y position of the drop
      // The modulo (%) operator makes the rain loop from bottom to top
      final progress = (animation.value + drop.offset) % 1.0;
      final currentY = progress *
          (size.height *
              1.2); // Multiply by 1.2 to make them fall a bit "off-screen"

      // Check if this particle should be a long streak or a small drop
      if (drop.isStreak) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(
              drop.x * size.width,
              currentY -
                  drop.length, // Start drawing above the calculated point
              drop.width,
              drop.length, // The length of the streak
            ),
            const Radius.circular(5),
          ),
          streakPaint,
        );
      } else {
        canvas.drawCircle(
          Offset(drop.x * size.width, currentY),
          drop.radius,
          dropPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant RainPainter oldDelegate) => false;
}

// A helper class to hold the properties of a single raindrop or streak
class _Raindrop {
  final double x;
  final double offset;
  final double radius;
  final double length;
  final double width;
  final bool isStreak;

  _Raindrop()
      : x = Random().nextDouble(),
        offset = Random().nextDouble(),
        radius = Random().nextDouble() * 2.0 + 1.0,
        length = Random().nextDouble() * 50 + 20,
        width = Random().nextDouble() * 1.5 + 0.5,
        isStreak = Random().nextDouble() > 0.85; // 15% chance to be a streak
}
