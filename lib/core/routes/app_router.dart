import 'package:flutter/material.dart';
import '../../presentation/views/home_view.dart';
import '../../presentation/views/quiz_view.dart';

class AppRouter {
  static const String home = '/';
  static const String quiz = '/quiz';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case quiz:
        return MaterialPageRoute(builder: (_) => const QuizView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
