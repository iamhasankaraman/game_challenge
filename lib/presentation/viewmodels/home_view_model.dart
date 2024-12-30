import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final gradientColors = [
    Colors.blue.shade900,
    Colors.purple.shade900,
  ];

  final iconSize = 80.0;
  final titleFontSize = 32.0;
  final scoreFontSize = 24.0;
  final buttonFontSize = 24.0;

  void navigateToQuiz(BuildContext context) {
    Navigator.pushNamed(context, '/quiz');
  }
}
