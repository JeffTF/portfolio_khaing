import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio_khaing/constant/strings.dart';
import 'package:portfolio_khaing/widgets/animated_background.dart';
import 'package:portfolio_khaing/widgets/animated_bg_v2.dart';

class ContactSection extends StatelessWidget {
  final bool isMobile;
  const ContactSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height,
      child: Stack(children: [
        // AnimatedBackground(color: theme.colorScheme.primary),
        AnimatedBackgroundV2(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact Me',
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
                'Feel free to reach out via email, phone, or the form below.',
                style: TextStyle(
                  fontSize: isMobile ? 18 : 24,
                  fontWeight: FontWeight.w500,
                ),
              )
                  .animate()
                  .fade(duration: 500.ms, delay: 200.ms)
                  .slideY(begin: 0.2, end: 0),
              const SizedBox(height: 24),

              // Contact Info
              Row(
                children: [
                  Icon(Icons.email, size: 20),
                  SizedBox(width: 8),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: isMobile ? 16 : 18,
                      height: 1.5,
                      color: theme.textTheme.bodyLarge?.color?.withOpacity(0.7),
                    ),
                    textAlign: isMobile ? TextAlign.center : TextAlign.left,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.phone, size: 20),
                  SizedBox(width: 8),
                  Text(
                    phoneNumber,
                    style: TextStyle(
                      fontSize: isMobile ? 16 : 18,
                      height: 1.5,
                      color: theme.textTheme.bodyLarge?.color?.withOpacity(0.7),
                    ),
                    textAlign: isMobile ? TextAlign.center : TextAlign.left,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Contact Form
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                child: Column(children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Your Name or Company Name',
                      labelStyle: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        height: 1.5,
                        color:
                            theme.textTheme.bodyLarge?.color?.withOpacity(0.7),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Your Email',
                      labelStyle: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        height: 1.5,
                        color:
                            theme.textTheme.bodyLarge?.color?.withOpacity(0.7),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Your Message',
                      labelStyle: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        height: 1.5,
                        color:
                            theme.textTheme.bodyLarge?.color?.withOpacity(0.7),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: theme.colorScheme.secondary,
                      )),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 60,
                    width: screenSize.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        // Handle submit
                      },
                      child: Text(
                        'Send Message',
                        style: TextStyle(
                          fontSize: isMobile ? 16 : 18,
                          height: 1.5,
                          color: theme.textTheme.bodyLarge?.color
                              ?.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
