import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class Themes {
  static final lightFlex = FlexThemeData.light(scheme: FlexScheme.redWine);
  static final darkFlex = FlexThemeData.dark(scheme: FlexScheme.redWine);

  // Notes: For more customization
  static final light = ThemeData.light().copyWith(
    colorScheme: const ColorScheme(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: surfaceColor,
      background: backgroundColor,
      error: errorColor,
      onPrimary: onPrimaryDarkColor,
      onSecondary: onSecondaryDarkColor,
      onSurface: onSurfaceDarkColor,
      onBackground: onBackgroundDarkColor,
      onError: onErrorDarkColor,
      brightness: Brightness.dark,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
    disabledColor: disableColor,
    unselectedWidgetColor: inactiveTextLightColor,
  );

  // Notes: For more customization
  static final dark = ThemeData.dark().copyWith(
    colorScheme: const ColorScheme(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: surfaceColor,
      background: backgroundColor,
      error: errorColor,
      onPrimary: onPrimaryDarkColor,
      onSecondary: onSecondaryDarkColor,
      onSurface: onSurfaceDarkColor,
      onBackground: onBackgroundDarkColor,
      onError: onErrorDarkColor,
      brightness: Brightness.dark,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
    disabledColor: disableColor,
    unselectedWidgetColor: inactiveTextLightColor,
  );
}
