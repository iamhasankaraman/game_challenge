import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:quiz_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap through quiz flow', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Start Quiz
      await tester.tap(find.text('Start Quiz'));
      await tester.pumpAndSettle();

      // Answer first question
      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pumpAndSettle();

      // Verify score is visible
      expect(find.textContaining('Score:'), findsOneWidget);
    });
  });
}
