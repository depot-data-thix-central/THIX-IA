import 'package:flutter/material.dart';

/// Extensions pratiques sur le [BuildContext].
extension BuildContextX on BuildContext {
  // ───── Theme ─────
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  bool get isDarkMode => theme.brightness == Brightness.dark;

  // ───── MediaQuery ─────
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get viewPadding => mediaQuery.padding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
  bool get isKeyboardVisible => viewInsets.bottom > 0;

  // ───── Navigation ─────
  NavigatorState get navigator => Navigator.of(this);
  void pop<T>([T? result]) => navigator.pop(result);
  Future<T?> push<T>(Widget page) => navigator.push<T>(
        MaterialPageRoute(builder: (_) => page),
      );
  Future<T?> pushReplacement<T>(Widget page) =>
      navigator.pushReplacement<T, dynamic>(
        MaterialPageRoute(builder: (_) => page),
      );

  // ───── Utilitaires ─────
  /// Affiche un snackbar rapide.
  void showSnackBar(String message, {Color? backgroundColor}) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
  }
}
