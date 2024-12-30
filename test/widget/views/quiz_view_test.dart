import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/presentation/viewmodels/quiz_view_model.dart';
import 'package:quiz_app/presentation/views/quiz_view.dart';

void main() {
  late QuizViewModel viewModel;

  setUp(() {
    viewModel = QuizViewModel();
  });

  testWidgets('QuizView should show loading initially',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<QuizViewModel>.value(
          value: viewModel,
          child: const QuizView(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('QuizView should show question after loading',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<QuizViewModel>.value(
          value: viewModel,
          child: const QuizView(),
        ),
      ),
    );

    await tester.pump();
    viewModel.startNewQuiz();
    await tester.pumpAndSettle();

    expect(find.byType(ElevatedButton), findsNWidgets(4)); // 4 options
    expect(find.byType(Text), findsWidgets); // Question text
  });
}
