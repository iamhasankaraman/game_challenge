import 'dart:async';
import 'package:flutter/material.dart';

class AppLocalizations {
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  final Locale locale;

  AppLocalizations(this.locale);

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'quiz_app': 'Quiz App',
      'last_score': 'Last Score: {}',
      'start_quiz': 'Start Quiz',
      'score': 'Score: {}',
      'congratulations': 'Congratulations!',
      'final_score': 'Final Score: {}',
      'back_to_home': 'Back to Home',
      'wrong_answer': 'Wrong Answer!',
      'try_again': 'Try Again',
    },
    'tr': {
      'quiz_app': 'Bilgi Yarışması',
      'last_score': 'Son Puan: {}',
      'start_quiz': 'Yarışmaya Başla',
      'score': 'Puan: {}',
      'congratulations': 'Tebrikler!',
      'final_score': 'Final Puanı: {}',
      'back_to_home': 'Ana Sayfaya Dön',
      'wrong_answer': 'Yanlış Cevap!',
      'try_again': 'Tekrar Dene',
    },
  };

  String translate(String key, [List<String>? args]) {
    final text = _localizedValues[locale.languageCode]?[key] ?? key;
    if (args == null || args.isEmpty) return text;

    String result = text;
    for (var arg in args) {
      result = result.replaceFirst('{}', arg);
    }
    return result;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'tr'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
