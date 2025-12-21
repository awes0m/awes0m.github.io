import 'package:flutter/material.dart';

/// Centralized design tokens for consistent theming across the app
class DesignTokens {
  // Gradient Colors - Purple-Blue Theme
  static const Color gradientPurple = Color(0xFF6a11cb);
  static const Color gradientBlue = Color(0xFF2575fc);
  static const Color gradientPurpleLight = Color(0xFF8e2de2);
  static const Color gradientBlueLight = Color(0xFF4a00e0);

  // Dark Mode Colors
  static const Color darkBackground = Color(0xFF1a1a2e);
  static const Color darkSecondary = Color(0xFF16213e);
  static const Color darkAccent = Color(0xFF0f3460);
  static const Color darkSurface = Color(0xFF121412);

  // Light Mode Colors
  static const Color lightBackground = Color(0xFFf5f7fa);
  static const Color lightSecondary = Color(0xFFe8eaf6);
  static const Color lightAccent = Color(0xFFc5cae9);
  static const Color lightSurface = Color(0xFFfbf9f5);

  // Gradient Definitions
  static LinearGradient primaryGradient({bool isHover = false}) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isHover
          ? [
              gradientPurple,
              gradientBlue,
              gradientPurpleLight,
            ]
          : [
              gradientPurple,
              gradientBlue,
            ],
    );
  }

  static LinearGradient darkCardGradient({bool isHover = false}) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isHover
          ? [
              darkBackground,
              darkSecondary,
              darkAccent,
            ]
          : [
              darkBackground,
              darkSecondary,
            ],
    );
  }

  static LinearGradient lightCardGradient({bool isHover = false}) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isHover
          ? [
              lightSecondary,
              lightAccent,
              const Color(0xFF9fa8da),
            ]
          : [
              lightSecondary,
              lightAccent,
            ],
    );
  }

  // Shadow Styles
  static List<BoxShadow> cardShadow({bool isHover = false}) {
    return [
      BoxShadow(
        color: isHover ? gradientPurple.withValues(alpha:0.3) : Colors.black45,
        blurRadius: isHover ? 20.0 : 10.0,
        offset: Offset(isHover ? 0 : 8, isHover ? 8 : 12),
      ),
    ];
  }

  static List<BoxShadow> glowShadow({Color? color}) {
    return [
      BoxShadow(
        color: (color ?? gradientPurple).withValues(alpha:0.3),
        blurRadius: 20,
        spreadRadius: 2,
      ),
    ];
  }

  // Border Styles
  static Border gradientBorder({bool isHover = false}) {
    return Border.all(
      color: isHover ? gradientPurple.withValues(alpha:0.5) : Colors.transparent,
      width: 2,
    );
  }

  // Border Radius
  static const double cardBorderRadius = 20.0;
  static const double smallBorderRadius = 12.0;
  static const double largeBorderRadius = 25.0;

  // Animation Durations
  static const Duration hoverDuration = Duration(milliseconds: 300);
  static const Duration quickDuration = Duration(milliseconds: 200);
  static const Duration slowDuration = Duration(milliseconds: 500);

  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;

  // Hover Scale
  static const double hoverScale = 1.02;
  static const double normalScale = 1.0;

  // Animation Curves
  static const Curve defaultCurve = Curves.easeInOut;
  static const Curve bounceCurve = Curves.elasticOut;
}
