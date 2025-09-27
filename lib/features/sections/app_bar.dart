import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_khaing/features/bloc/language_cubit.dart';
import 'package:portfolio_khaing/language/lang.dart';
import '../../widgets/custom_button.dart';

class AppBarSection extends StatelessWidget implements PreferredSizeWidget {
  final bool isMobile;
  final int currentSection;
  final VoidCallback toggleTheme;
  final Function(int) scrollToSection;
  final VoidCallback toggleMobileMenu;
  final bool isMobileMenuOpen;

  const AppBarSection({
    super.key,
    required this.isMobile,
    required this.currentSection,
    required this.toggleTheme,
    required this.scrollToSection,
    required this.toggleMobileMenu,
    required this.isMobileMenuOpen,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      //backgroundColor: theme.scaffoldBackgroundColor.withOpacity(0.9),
      systemOverlayStyle: theme.brightness == Brightness.light
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
      title: AnimatedOpacity(
        opacity: isMobile ? 0 : 1.0,
        duration: const Duration(milliseconds: 300),
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Myat Hsu Khaing',
                style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold),
              ),
              if (!isMobile)
                BlocBuilder<LanguageCubit, LanguageMode>(
                  builder: (context, mode) {
                    final strings = mode == LanguageMode.normal
                        ? AppStrings.normal
                        : AppStrings.linkedin;
                    return Row(
                      children: [
                        _buildNavItem(context, strings['home']!, 0),
                        _buildNavItem(context, strings['about']!, 1),
                        _buildNavItem(context, strings['skills']!, 2),
                        _buildNavItem(context, strings['projects']!, 3),
                        _buildNavItem(context, strings['contact']!, 4),
                        const SizedBox(width: 15),
                        IconButton(
                          icon: Icon(
                              theme.brightness == Brightness.light
                                  ? Icons.dark_mode_outlined
                                  : Icons.light_mode_outlined,
                              color: theme.textTheme.bodyLarge?.color),
                          onPressed: toggleTheme,
                        ),
                        const SizedBox(width: 15),
                        InkWell(
                            onTap: () =>
                                context.read<LanguageCubit>().toggleLanguage(),
                            child: Image.asset(
                              'assets/language/${mode.name}.png',
                              height: 30,
                              width: 30,
                              fit: BoxFit.scaleDown,
                            )),
                      ],
                    );
                  },
                ),
            ],
          ),
        ),
      ),
      actions: isMobile
          ? [
              IconButton(
                icon: Icon(isMobileMenuOpen ? Icons.close : Icons.menu,
                    color: theme.textTheme.bodyLarge?.color),
                onPressed: toggleMobileMenu,
              ),
              IconButton(
                icon: Icon(
                    theme.brightness == Brightness.light
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined,
                    color: theme.textTheme.bodyLarge?.color),
                onPressed: toggleTheme,
              ),
            ]
          : null,
    );
  }

  Widget _buildNavItem(BuildContext context, String title, int index) {
    final theme = Theme.of(context);
    final isSelected = currentSection == index;

    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: () => scrollToSection(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.textTheme.bodyLarge?.color,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const SizedBox(height: 4),
            if (isSelected)
              Container(
                height: 2,
                width: 20,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
