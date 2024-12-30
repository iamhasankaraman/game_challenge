import 'package:flutter/material.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_colors.dart';

extension ContextExtension on BuildContext {
  // MediaQuery Extensions
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

  // Theme Extensions
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  // Custom Text Styles
  TextStyle get heading1 => AppTextStyles.heading1;
  TextStyle get heading2 => AppTextStyles.heading2;
  TextStyle get bodyText => AppTextStyles.body;
  TextStyle get buttonText => AppTextStyles.button;
  TextStyle get scoreText => AppTextStyles.score;

  // Custom Colors
  Color get primaryColor => AppColors.primary;
  Color get secondaryColor => AppColors.secondary;
  Color get accentColor => AppColors.accent;
  Color get errorColor => AppColors.error;
  Color get successColor => AppColors.success;

  // Navigation Extensions
  void pop<T>([T? result]) => Navigator.of(this).pop(result);
  void pushNamed(String routeName) => Navigator.of(this).pushNamed(routeName);
  void pushReplacementNamed(String routeName) =>
      Navigator.of(this).pushReplacementNamed(routeName);
  void pushNamedAndRemoveUntil(String routeName) =>
      Navigator.of(this).pushNamedAndRemoveUntil(routeName, (_) => false);
}
