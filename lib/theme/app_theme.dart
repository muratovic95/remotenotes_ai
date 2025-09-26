import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the application.
class AppTheme {
  AppTheme._();

  // Color specifications based on design system
  static const Color primaryLight = Color(0xFF2563EB);
  static const Color secondaryLight = Color(0xFF64748B);
  static const Color successLight = Color(0xFF059669);
  static const Color warningLight = Color(0xFFD97706);
  static const Color errorLight = Color(0xFFDC2626);
  static const Color surfaceLight = Color(0xFFF8FAFC);
  static const Color surfaceVariantLight = Color(0xFFF1F5F9);
  static const Color onSurfaceLight = Color(0xFF0F172A);
  static const Color onSurfaceVariantLight = Color(0xFF475569);
  static const Color outlineLight = Color(0xFFCBD5E1);
  static const Color backgroundLight = Color(0xFFF8FAFC);

  static const Color primaryDark = Color(0xFF3B82F6);
  static const Color secondaryDark = Color(0xFF94A3B8);
  static const Color successDark = Color(0xFF10B981);
  static const Color warningDark = Color(0xFFF59E0B);
  static const Color errorDark = Color(0xFFEF4444);
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color surfaceVariantDark = Color(0xFF334155);
  static const Color onSurfaceDark = Color(0xFFF8FAFC);
  static const Color onSurfaceVariantDark = Color(0xFFCBD5E1);
  static const Color outlineDark = Color(0xFF475569);
  static const Color backgroundDark = Color(0xFF0F172A);

  // Shadow colors
  static const Color shadowLight = Color(0x33000000); // 20% opacity
  static const Color shadowDark = Color(0x33000000);

  /// Light theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primaryLight,
      onPrimary: Colors.white,
      primaryContainer: primaryLight.withValues(alpha: 0.1),
      onPrimaryContainer: primaryLight,
      secondary: secondaryLight,
      onSecondary: Colors.white,
      secondaryContainer: secondaryLight.withValues(alpha: 0.1),
      onSecondaryContainer: secondaryLight,
      tertiary: successLight,
      onTertiary: Colors.white,
      tertiaryContainer: successLight.withValues(alpha: 0.1),
      onTertiaryContainer: successLight,
      error: errorLight,
      onError: Colors.white,
      errorContainer: errorLight.withValues(alpha: 0.1),
      onErrorContainer: errorLight,
      surface: surfaceLight,
      onSurface: onSurfaceLight,
      surfaceContainerHighest: surfaceVariantLight,
      onSurfaceVariant: onSurfaceVariantLight,
      outline: outlineLight,
      outlineVariant: outlineLight.withValues(alpha: 0.5),
      shadow: shadowLight,
      scrim: Colors.black.withValues(alpha: 0.5),
      inverseSurface: onSurfaceLight,
      onInverseSurface: surfaceLight,
      inversePrimary: primaryDark,
    ),
    scaffoldBackgroundColor: backgroundLight,
    cardColor: surfaceLight,
    dividerColor: outlineLight,
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceLight,
      foregroundColor: onSurfaceLight,
      elevation: 0,
      shadowColor: shadowLight,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: onSurfaceLight,
      ),
      iconTheme: const IconThemeData(
        color: onSurfaceLight,
        size: 24,
      ),
      actionsIconTheme: const IconThemeData(
        color: onSurfaceLight,
        size: 24,
      ),
    ),
    cardTheme: CardTheme(
      color: surfaceLight,
      elevation: 2,
      shadowColor: shadowLight,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.all(8.0),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceLight,
      selectedItemColor: primaryLight,
      unselectedItemColor: onSurfaceVariantLight,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: surfaceLight,
      indicatorColor: primaryLight.withValues(alpha: 0.1),
      surfaceTintColor: Colors.transparent,
      elevation: 8,
      shadowColor: shadowLight,
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: primaryLight,
          );
        }
        return GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: onSurfaceVariantLight,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(
            color: primaryLight,
            size: 24,
          );
        }
        return const IconThemeData(
          color: onSurfaceVariantLight,
          size: 24,
        );
      }),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryLight,
      foregroundColor: Colors.white,
      elevation: 4,
      focusElevation: 6,
      hoverElevation: 6,
      highlightElevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: primaryLight,
        elevation: 2,
        shadowColor: shadowLight,
        surfaceTintColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryLight,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        side: const BorderSide(color: outlineLight, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryLight,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textTheme: _buildTextTheme(isLight: true),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: surfaceLight,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: outlineLight, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: outlineLight, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: primaryLight, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: errorLight, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: errorLight, width: 2),
      ),
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: onSurfaceVariantLight,
      ),
      hintStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: onSurfaceVariantLight.withValues(alpha: 0.6),
      ),
      errorStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: errorLight,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight;
        }
        return onSurfaceVariantLight;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight.withValues(alpha: 0.5);
        }
        return outlineLight;
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(Colors.white),
      side: const BorderSide(color: outlineLight, width: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight;
        }
        return outlineLight;
      }),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primaryLight,
      linearTrackColor: outlineLight,
      circularTrackColor: outlineLight,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: primaryLight,
      thumbColor: primaryLight,
      overlayColor: primaryLight.withValues(alpha: 0.2),
      inactiveTrackColor: outlineLight,
      trackHeight: 4,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: primaryLight,
      unselectedLabelColor: onSurfaceVariantLight,
      indicatorColor: primaryLight,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: onSurfaceLight.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: surfaceLight,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: onSurfaceLight,
      contentTextStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: surfaceLight,
      ),
      actionTextColor: primaryLight,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 4,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: surfaceLight,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
    ), dialogTheme: DialogThemeData(backgroundColor: surfaceLight),
  );

  /// Dark theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: primaryDark,
      onPrimary: backgroundDark,
      primaryContainer: primaryDark.withValues(alpha: 0.2),
      onPrimaryContainer: primaryDark,
      secondary: secondaryDark,
      onSecondary: backgroundDark,
      secondaryContainer: secondaryDark.withValues(alpha: 0.2),
      onSecondaryContainer: secondaryDark,
      tertiary: successDark,
      onTertiary: backgroundDark,
      tertiaryContainer: successDark.withValues(alpha: 0.2),
      onTertiaryContainer: successDark,
      error: errorDark,
      onError: backgroundDark,
      errorContainer: errorDark.withValues(alpha: 0.2),
      onErrorContainer: errorDark,
      surface: surfaceDark,
      onSurface: onSurfaceDark,
      surfaceContainerHighest: surfaceVariantDark,
      onSurfaceVariant: onSurfaceVariantDark,
      outline: outlineDark,
      outlineVariant: outlineDark.withValues(alpha: 0.5),
      shadow: shadowDark,
      scrim: Colors.black.withValues(alpha: 0.5),
      inverseSurface: onSurfaceDark,
      onInverseSurface: surfaceDark,
      inversePrimary: primaryLight,
    ),
    scaffoldBackgroundColor: backgroundDark,
    cardColor: surfaceDark,
    dividerColor: outlineDark,
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceDark,
      foregroundColor: onSurfaceDark,
      elevation: 0,
      shadowColor: shadowDark,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: onSurfaceDark,
      ),
      iconTheme: const IconThemeData(
        color: onSurfaceDark,
        size: 24,
      ),
      actionsIconTheme: const IconThemeData(
        color: onSurfaceDark,
        size: 24,
      ),
    ),
    cardTheme: CardTheme(
      color: surfaceDark,
      elevation: 2,
      shadowColor: shadowDark,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.all(8.0),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceDark,
      selectedItemColor: primaryDark,
      unselectedItemColor: onSurfaceVariantDark,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: surfaceDark,
      indicatorColor: primaryDark.withValues(alpha: 0.2),
      surfaceTintColor: Colors.transparent,
      elevation: 8,
      shadowColor: shadowDark,
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: primaryDark,
          );
        }
        return GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: onSurfaceVariantDark,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(
            color: primaryDark,
            size: 24,
          );
        }
        return const IconThemeData(
          color: onSurfaceVariantDark,
          size: 24,
        );
      }),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryDark,
      foregroundColor: backgroundDark,
      elevation: 4,
      focusElevation: 6,
      hoverElevation: 6,
      highlightElevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: backgroundDark,
        backgroundColor: primaryDark,
        elevation: 2,
        shadowColor: shadowDark,
        surfaceTintColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryDark,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        side: const BorderSide(color: outlineDark, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryDark,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textTheme: _buildTextTheme(isLight: false),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: surfaceDark,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: outlineDark, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: outlineDark, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: primaryDark, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: errorDark, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: errorDark, width: 2),
      ),
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: onSurfaceVariantDark,
      ),
      hintStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: onSurfaceVariantDark.withValues(alpha: 0.6),
      ),
      errorStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: errorDark,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryDark;
        }
        return onSurfaceVariantDark;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryDark.withValues(alpha: 0.5);
        }
        return outlineDark;
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryDark;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(backgroundDark),
      side: const BorderSide(color: outlineDark, width: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryDark;
        }
        return outlineDark;
      }),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primaryDark,
      linearTrackColor: outlineDark,
      circularTrackColor: outlineDark,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: primaryDark,
      thumbColor: primaryDark,
      overlayColor: primaryDark.withValues(alpha: 0.2),
      inactiveTrackColor: outlineDark,
      trackHeight: 4,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: primaryDark,
      unselectedLabelColor: onSurfaceVariantDark,
      indicatorColor: primaryDark,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: onSurfaceDark.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: surfaceDark,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: onSurfaceDark,
      contentTextStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: surfaceDark,
      ),
      actionTextColor: primaryDark,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 4,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: surfaceDark,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
    ), dialogTheme: DialogThemeData(backgroundColor: surfaceDark),
  );

  /// Helper method to build text theme based on brightness
  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color textHighEmphasis = isLight ? onSurfaceLight : onSurfaceDark;
    final Color textMediumEmphasis =
        isLight ? onSurfaceVariantLight : onSurfaceVariantDark;
    final Color textDisabled = isLight
        ? onSurfaceVariantLight.withValues(alpha: 0.6)
        : onSurfaceVariantDark.withValues(alpha: 0.6);

    return TextTheme(
      displayLarge: GoogleFonts.inter(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: -0.25,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        color: textHighEmphasis,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: textHighEmphasis,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: textHighEmphasis,
        letterSpacing: 0,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textHighEmphasis,
        letterSpacing: 0.15,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textHighEmphasis,
        letterSpacing: 0.1,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: 0.5,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: 0.25,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textMediumEmphasis,
        letterSpacing: 0.4,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textHighEmphasis,
        letterSpacing: 0.1,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textMediumEmphasis,
        letterSpacing: 0.5,
      ),
      labelSmall: GoogleFonts.jetBrainsMono(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: textDisabled,
        letterSpacing: 0.5,
      ),
    );
  }
}
