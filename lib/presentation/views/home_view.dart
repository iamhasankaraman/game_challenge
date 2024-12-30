import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/quiz_view_model.dart';
import '../../core/extensions/context_extension.dart';
import '../../core/routes/app_router.dart';
import '../../core/localization/app_localizations.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [context.primaryColor, context.secondaryColor],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.translate('quiz_app'),
                  style: context.heading1,
                ),
                const SizedBox(height: 24),
                Consumer<QuizViewModel>(
                  builder: (context, viewModel, child) => Text(
                    AppLocalizations.of(context)!.translate(
                        'last_score', [viewModel.lastScore.toString()]),
                    style: context.scoreText,
                  ),
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: () => context.pushNamed(AppRouter.quiz),
                  child: Text(
                    AppLocalizations.of(context)!.translate('start_quiz'),
                    style: context.buttonText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
