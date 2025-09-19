import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_khaing/features/bloc/language_cubit.dart';
import 'package:portfolio_khaing/widgets/animated_bg_v2.dart';
import 'package:portfolio_khaing/widgets/nightsky_bg.dart';
import 'package:portfolio_khaing/widgets/shooting_stars_bg.dart';
import '../../language/lang.dart';
import '../../widgets/animated_background.dart';
import '../../widgets/custom_button.dart';

class HeroSection extends StatelessWidget {
  final bool isMobile;
  final Function(int) scrollToSection;

  const HeroSection({
    super.key,
    required this.isMobile,
    required this.scrollToSection,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    return BlocBuilder<LanguageCubit, LanguageMode>(
      builder: (context, mode) {
        final strings = mode == LanguageMode.normal
            ? AppStrings.normal
            : AppStrings.linkedin;
        return SizedBox(
          height: screenSize.height,
          child: Stack(
            children: [
              StarryNightScreen(),
              // AnimatedBackgroundV2(),
              // ShootingStarsBackground(),
              //AnimatedBackground(color: theme.colorScheme.primary),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(isMobile ? 24 : 48),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: isMobile
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        strings['hi']!,
                        style: TextStyle(
                          fontSize: isMobile ? 20 : 24,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                          .animate()
                          .fade(duration: 500.ms, delay: 100.ms)
                          .slideY(begin: 0.2, end: 0),
                      const SizedBox(height: 8),
                      Text(
                        strings['kkm']!,
                        style: TextStyle(
                          fontSize: isMobile ? 40 : 64,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      )
                          .animate()
                          .fade(duration: 500.ms, delay: 200.ms)
                          .slideY(begin: 0.2, end: 0),
                      const SizedBox(height: 8),
                      Text(
                        strings['mobileDev']!,
                        style: TextStyle(
                          fontSize: isMobile ? 18 : 24,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                          .animate()
                          .fade(duration: 500.ms, delay: 300.ms)
                          .slideY(begin: 0.2, end: 0),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: isMobile ? screenSize.width * 0.8 : 500,
                        child: Text(
                          strings['profileText1']!,
                          style: TextStyle(
                            fontSize: isMobile ? 16 : 18,
                            height: 1.5,
                            color: theme.textTheme.bodyLarge?.color
                                ?.withOpacity(0.7),
                          ),
                          textAlign:
                              isMobile ? TextAlign.center : TextAlign.left,
                        ),
                      )
                          .animate()
                          .fade(duration: 500.ms, delay: 400.ms)
                          .slideY(begin: 0.2, end: 0),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: isMobile
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.start,
                        children: [
                          CustomButton(
                            text: strings['getInTouch']!,
                            isPrimary: true,
                            onPressed: () => scrollToSection(4),
                          )
                              .animate()
                              .fade(duration: 500.ms, delay: 500.ms)
                              .slideY(begin: 0.2, end: 0),
                          const SizedBox(width: 16),
                          CustomButton(
                            text: strings['viewProjects']!,
                            isPrimary: false,
                            onPressed: () => scrollToSection(3),
                          )
                              .animate()
                              .fade(duration: 500.ms, delay: 600.ms)
                              .slideY(begin: 0.2, end: 0),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: theme.colorScheme.primary,
                      size: 32,
                    ),
                    onPressed: () => scrollToSection(1),
                  )
                      .animate(
                        onPlay: (controller) => controller.repeat(),
                      )
                      .moveY(
                        begin: 0,
                        end: 10,
                        duration: 1.seconds,
                        curve: Curves.easeInOut,
                      )
                      .then(delay: 500.ms)
                      .moveY(
                        begin: 10,
                        end: 0,
                        duration: 1.seconds,
                        curve: Curves.easeInOut,
                      ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
