import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio_khaing/widgets/nightsky_bg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/rainy_window.dart';
import '../bloc/language_cubit.dart';
import '../sections/app_bar.dart';
import '../sections/contact_section.dart';
import '../sections/hero_section.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  const HomeScreen({
    super.key,
    required this.toggleTheme,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(5, (_) => GlobalKey());
  int _currentSection = 0;
  bool _isMobileMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateCurrentSection);
    WidgetsBinding.instance.addPostFrameCallback((_) => _showWelcomeDialog());
  }

  void _showWelcomeDialog() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenDialog = prefs.getBool("hasSeenDialog") ?? false;

    if (hasSeenDialog) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final theme = Theme.of(context);
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: theme.dialogBackgroundColor,
          title: const Text("Welcome!"),
          content: const Text("Would you like LinkedIn-style wording?"),
          actions: [
            TextButton(
              onPressed: () async {
                await prefs.setBool("hasSeenDialog", true);
                Navigator.of(context).pop();
              },
              child: const Text("Normal"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
              ),
              onPressed: () async {
                await prefs.setBool("hasSeenDialog", true);
                Navigator.of(context).pop();
                context.read<LanguageCubit>().toggleLanguage();
              },
              child: Text(
                "LinkedIn Mode",
                style: TextStyle(color: theme.colorScheme.onPrimary),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateCurrentSection);
    _scrollController.dispose();
    super.dispose();
  }

  // void _updateCurrentSection() {
  //   final viewportHeight = MediaQuery.of(context).size.height - kToolbarHeight;
  //   final scrollOffset = _scrollController.offset;
  //   final viewportMiddle = scrollOffset + (viewportHeight / 2);

  //   for (int i = 0; i < _sectionKeys.length; i++) {
  //     final sectionKey = _sectionKeys[i];
  //     final sectionContext = sectionKey.currentContext;

  //     if (sectionContext != null) {
  //       final RenderBox box = sectionContext.findRenderObject() as RenderBox;
  //       final sectionPosition = box.localToGlobal(Offset.zero).dy;
  //       final sectionHeight = box.size.height;

  //       if (viewportMiddle >= sectionPosition &&
  //           viewportMiddle < sectionPosition + sectionHeight) {
  //         if (_currentSection != i) {
  //           setState(() => _currentSection = i);
  //         }
  //         break;
  //       }
  //     }
  //   }
  // }
  void _updateCurrentSection() {
    final sectionHeight = MediaQuery.of(context).size.height - kToolbarHeight;

    if (sectionHeight <= 0) return;

    final currentVisibleSection =
        (_scrollController.offset + 100) / sectionHeight;

    int newSection = currentVisibleSection.floor();

    newSection = newSection.clamp(0, _sectionKeys.length - 1);

    if (_currentSection != newSection) {
      setState(() {
        _currentSection = newSection;
      });
    }
  }

  void _scrollToSection(int index) {
    final sectionKey = _sectionKeys[index];
    final sectionContext = sectionKey.currentContext;

    if (sectionContext != null) {
      Scrollable.ensureVisible(
        sectionContext,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }

    if (_isMobileMenuOpen) {
      setState(() => _isMobileMenuOpen = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 768;
    final theme = Theme.of(context);

    return Stack(children: [
      theme.brightness == Brightness.light
          ? RainyWindow()
          : StarryNightScreen(),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBarSection(
          isMobile: isMobile,
          currentSection: _currentSection,
          toggleTheme: widget.toggleTheme,
          scrollToSection: _scrollToSection,
          toggleMobileMenu: () =>
              setState(() => _isMobileMenuOpen = !_isMobileMenuOpen),
          isMobileMenuOpen: _isMobileMenuOpen,
        ),
        body: Stack(children: [
          SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  key: _sectionKeys[0],
                  height: screenSize.height - kToolbarHeight,
                  child: HeroSection(
                    isMobile: isMobile,
                    scrollToSection: _scrollToSection,
                  ),
                ),
                SizedBox(
                    key: _sectionKeys[1],
                    height: screenSize.height - kToolbarHeight,
                    child: ContactSection(
                      isMobile: isMobile,
                    )),
                SizedBox(
                  key: _sectionKeys[2],
                  height: screenSize.height - kToolbarHeight,
                  child: Center(child: Text('Skills Section')),
                ),
                SizedBox(
                  key: _sectionKeys[3],
                  height: screenSize.height - kToolbarHeight,
                  child: Center(child: Text('Project Section')),
                ),
                SizedBox(
                    key: _sectionKeys[4],
                    height: screenSize.height - kToolbarHeight,
                    child: ContactSection(
                      isMobile: isMobile,
                    )),
              ],
            ),
          ),
        ]),
      ),
    ]);
  }

  // ... Rest of the widget methods (app bar, sections, etc.)
  // We'll move these to separate files in the next step
}
