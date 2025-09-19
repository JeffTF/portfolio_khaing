import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isPrimary;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.isPrimary,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary
            ? theme.colorScheme.primary
            : theme.brightness == Brightness.light
                ? Colors.white
                : theme.scaffoldBackgroundColor,
        foregroundColor: isPrimary ? Colors.white : theme.colorScheme.primary,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: isPrimary
              ? BorderSide.none
              : BorderSide(color: theme.colorScheme.primary),
        ),
        elevation: isPrimary ? 2 : 0,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }
}
