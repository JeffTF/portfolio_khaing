import 'package:flutter/material.dart';
import 'package:portfolio_khaing/features/screens/home_screen.dart';
import 'package:portfolio_khaing/services/locator.dart';

import 'config/theme.dart';
import 'services/bloc_helper.dart';

void main() {
  locator();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocHelper(
      child: MaterialApp(
        title: "Khaing's Portfolio",
        debugShowCheckedModeBanner: false,
        theme: AppTheme.blueMistLightTheme,
        darkTheme: AppTheme.softGirlDarkTheme,
        themeMode: _themeMode,
        home: HomeScreen(toggleTheme: toggleTheme),
      ),
    );
  }
}
