import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/quiz_view_model.dart';
import '../../core/extensions/context_extension.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';
import '../../core/localization/app_localizations.dart';

class QuizView extends StatefulWidget {
  const QuizView({super.key});

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView>
    with SingleTickerProviderStateMixin {
  late QuizViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<QuizViewModel>();
    _viewModel.initializeAnimations(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _viewModel.startNewQuiz();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<QuizViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.currentQuestions.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final currentQuestion =
              viewModel.currentQuestions[viewModel.currentQuestionIndex];

          return Stack(
            children: [
              Container(
                height: context.height,
                width: context.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [context.primaryColor, context.secondaryColor],
                  ),
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          // Progress and Score
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.translate(
                                    'score', [viewModel.score.toString()]),
                                style: context.scoreText,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: LinearProgressIndicator(
                                    value: viewModel.progressValue,
                                    backgroundColor:
                                        Colors.white.withOpacity(0.2),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        context.accentColor),
                                    minHeight: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // Question
                          AnimatedBuilder(
                            animation: viewModel.fadeAnimation,
                            builder: (context, child) {
                              return Transform(
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.002)
                                  ..rotateY(
                                      viewModel.fadeAnimation.value * pi * 1.5)
                                  ..scale(
                                    1.0 - (viewModel.fadeAnimation.value * 0.6),
                                    1.0 - (viewModel.fadeAnimation.value * 0.6),
                                  ),
                                alignment: Alignment.center,
                                child: Opacity(
                                  opacity: (1.0 - viewModel.fadeAnimation.value)
                                      .clamp(0.0, 1.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(24),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: context.accentColor
                                              .withOpacity(0.2),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          Localizations.localeOf(context)
                                                      .languageCode ==
                                                  'tr'
                                              ? currentQuestion.questionTr
                                              : currentQuestion.questionEn,
                                          style: context.heading2,
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 32),
                                        ...List.generate(
                                          currentQuestion.optionsEn.length,
                                          (index) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 16),
                                            child: AnimatedBuilder(
                                              animation:
                                                  viewModel.fadeAnimation,
                                              builder: (context, child) {
                                                return Transform.translate(
                                                  offset: Offset(
                                                    200 *
                                                        viewModel.fadeAnimation
                                                            .value *
                                                        (index.isEven ? 1 : -1),
                                                    0,
                                                  ),
                                                  child: Opacity(
                                                    opacity: (1.0 -
                                                            viewModel
                                                                .fadeAnimation
                                                                .value)
                                                        .clamp(0.0, 1.0),
                                                    child: child,
                                                  ),
                                                );
                                              },
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    final isCorrect =
                                                        await viewModel
                                                            .checkAnswer(index);
                                                    if (isCorrect &&
                                                        viewModel
                                                            .isQuizCompleted) {
                                                      viewModel
                                                          .showSuccessDialog();
                                                    }
                                                  },
                                                  child: Text(
                                                    Localizations.localeOf(
                                                                    context)
                                                                .languageCode ==
                                                            'tr'
                                                        ? currentQuestion
                                                            .optionsTr[index]
                                                        : currentQuestion
                                                            .optionsEn[index],
                                                    style: context.buttonText,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: viewModel.confettiController,
                  blastDirection: pi / 2,
                  maxBlastForce: 5,
                  minBlastForce: 2,
                  emissionFrequency: 0.05,
                  numberOfParticles: 50,
                  gravity: 0.1,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.disposeAnimations();
    super.dispose();
  }
}
