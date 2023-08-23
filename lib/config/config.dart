import 'package:flutter/material.dart';

const smallDistance = 8.0;
const mediumDistance = 16.0;
const largeDistance = 24.0;
const xLargeDistance = 32.0;

const smallRadius = 8.0;
const mediumRadius = 16.0;
const largeRadius = 24.0;
const xLargeRadius = 32.0;

const primaryColor = Color(0xffF79860);

//dark colors
const darkBackgroundColor = Color(0xff101010);
const darkSurfaceColor = Color(0xff181818);

const darkColorScheme = ColorScheme(
  primary: primaryColor,
  primaryContainer: Colors.white,
  secondary: primaryColor,
  secondaryContainer: primaryColor,
  surface: darkSurfaceColor,
  background: darkBackgroundColor,
  error: Colors.red,
  onPrimary: primaryColor,
  onSecondary: primaryColor,
  onSurface: darkSurfaceColor,
  onBackground: darkBackgroundColor,
  onError: Colors.red,
  brightness: Brightness.dark,
);

ThemeData themeData(BuildContext context) {
  return ThemeData(
    canvasColor: Colors.white,
    primaryColor: primaryColor,
    cardColor: Colors.black,
    scaffoldBackgroundColor: darkBackgroundColor,
    iconTheme: const IconThemeData(color: Colors.white),
    colorScheme: darkColorScheme,
  );
}
