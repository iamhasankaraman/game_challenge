import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quiz_app/presentation/viewmodels/quiz_view_model.dart';

class MockTickerProvider extends Mock implements TickerProvider {}

void main() {
  late QuizViewModel viewModel;
  late MockTickerProvider mockTickerProvider;

  setUp(() {
    mockTickerProvider = MockTickerProvider();
    viewModel = QuizViewModel();
    viewModel.initializeAnimations(mockTickerProvider);
  });

  group('QuizViewModel Tests', () {
    test('initial values should be correct', () {
      expect(viewModel.currentQuestions, isEmpty);
      expect(viewModel.currentQuestionIndex, 0);
      expect(viewModel.score, 0);
      expect(viewModel.lastScore, 0);
      expect(viewModel.isAnimating, false);
    });

    test('startNewQuiz should reset values and shuffle questions', () {
      viewModel.startNewQuiz();

      expect(viewModel.currentQuestions, isNotEmpty);
      expect(viewModel.currentQuestionIndex, 0);
      expect(viewModel.score, 0);
    });

    test('checkAnswer should increase score for correct answer', () async {
      viewModel.startNewQuiz();
      final correctIndex = viewModel.currentQuestions.first.correctAnswerIndex;

      final result = await viewModel.checkAnswer(correctIndex);

      expect(result, true);
      expect(viewModel.score, 50);
    });
  });
}
