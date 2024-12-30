import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_router.dart';
import 'core/di/service_locator.dart';
import 'core/utils/global_context.dart';
import 'core/localization/app_localizations.dart';
import 'presentation/viewmodels/quiz_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<QuizViewModel>()),
      ],
      child: MaterialApp(
        navigatorKey: GlobalContext.instance.navigatorKey,
        title: 'Quiz App',
        theme: AppTheme.light,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppRouter.home,
        supportedLocales: const [
          Locale('en', ''),
          Locale('tr', ''),
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}
