import 'package:flutter/material.dart';

class DayCycleScreen extends StatefulWidget {
  const DayCycleScreen({super.key});

  @override
  State<DayCycleScreen> createState() => _DayCycleScreenState();
}

class _DayCycleScreenState extends State<DayCycleScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // We need multiple animations for different parts of the scene
  late Animation<Color?> _topSkyColor;
  late Animation<Color?> _bottomSkyColor;
  late Animation<Alignment> _sunAlignment;
  late Animation<Color?> _sunColor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10), // A 10-second day/night cycle
    )..repeat(); // Loop the animation forever

    // 1. Animation for the top part of the sky gradient
    _topSkyColor = TweenSequence<Color?>([
      // Sunrise
      TweenSequenceItem(
        tween: ColorTween(
            begin: const Color(0xFF0d47a1), end: const Color(0xFF42a5f5)),
        weight: 45.0, // Takes 45% of the duration
      ),
      // Midday (stays the same color)
      TweenSequenceItem(
        tween: ConstantTween<Color?>(const Color(0xFF42a5f5)),
        weight: 10.0, // Takes 10%
      ),
      // Sunset
      TweenSequenceItem(
        tween: ColorTween(
            begin: const Color(0xFF42a5f5), end: const Color(0xFF0d47a1)),
        weight: 45.0, // Takes 45%
      ),
    ]).animate(_controller);

    // 2. Animation for the bottom part of the sky gradient
    _bottomSkyColor = TweenSequence<Color?>([
      // Sunrise
      TweenSequenceItem(
        tween: ColorTween(
            begin: const Color(0xFFffb74d), end: const Color(0xFF90caf9)),
        weight: 45.0,
      ),
      // Midday
      TweenSequenceItem(
        tween: ConstantTween<Color?>(const Color(0xFF90caf9)),
        weight: 10.0,
      ),
      // Sunset
      TweenSequenceItem(
        tween: ColorTween(
            begin: const Color(0xFF90caf9), end: const Color(0xFFffb74d)),
        weight: 45.0,
      ),
    ]).animate(_controller);

    // 3. Animation for the Sun's position (moves in an arc)
    _sunAlignment = TweenSequence<Alignment>([
      // Rise
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: const Alignment(-1.1, 0.8), // Starts from bottom-left
          end: const Alignment(0.0, -0.8), // Rises to top-center
        ),
        weight: 50.0,
      ),
      // Set
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: const Alignment(0.0, -0.8), // Starts from top-center
          end: const Alignment(1.1, 0.8), // Sets at bottom-right
        ),
        weight: 50.0,
      ),
    ]).animate(_controller);

    // 4. Animation for the Sun's color
    _sunColor = TweenSequence<Color?>([
      // Sunrise color
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.orange, end: Colors.yellow),
        weight: 50.0,
      ),
      // Sunset color
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.yellow, end: Colors.orange),
        weight: 50.0,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AnimatedBuilder is a performance-optimized widget that rebuilds
      // only its child when the animation value changes.
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _topSkyColor
                      .value!, // Use the current color from the animation
                  _bottomSkyColor.value!,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: [
                // The Sun
                Align(
                  alignment: _sunAlignment
                      .value, // Use current alignment from animation
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          _sunColor.value, // Use current color from animation
                      boxShadow: [
                        BoxShadow(
                          color: Colors.yellow.withOpacity(0.8),
                          blurRadius: 20.0,
                          spreadRadius: 5.0,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
