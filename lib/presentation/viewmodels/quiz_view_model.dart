import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:confetti/confetti.dart';
import '../../data/models/quiz_question.dart';
import 'base_dialog_model.dart';
import '../../core/utils/global_context.dart';
import '../../core/routes/app_router.dart';
import '../../core/extensions/context_extension.dart';
import '../../core/constants/app_constants.dart';
import '../../core/localization/app_localizations.dart';

class QuizViewModel extends ChangeNotifier {
  final List<QuizQuestion> _questions = [
    QuizQuestion(
      questionEn: "What is the capital of Turkey?",
      questionTr: "Türkiye'nin başkenti neresidir?",
      optionsEn: ["Istanbul", "Ankara", "Izmir", "Bursa"],
      optionsTr: ["İstanbul", "Ankara", "İzmir", "Bursa"],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      questionEn: "Which planet is known as the Red Planet?",
      questionTr: "Hangi gezegen Kızıl Gezegen olarak bilinir?",
      optionsEn: ["Venus", "Mars", "Jupiter", "Saturn"],
      optionsTr: ["Venüs", "Mars", "Jüpiter", "Satürn"],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      questionEn: "What is the largest ocean on Earth?",
      questionTr: "Dünyanın en büyük okyanusu hangisidir?",
      optionsEn: ["Atlantic", "Indian", "Pacific", "Arctic"],
      optionsTr: ["Atlas", "Hint", "Pasifik", "Arktik"],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionEn: "Who painted the Mona Lisa?",
      questionTr: "Mona Lisa'yı kim resmetmiştir?",
      optionsEn: ["Van Gogh", "Da Vinci", "Picasso", "Michelangelo"],
      optionsTr: ["Van Gogh", "Da Vinci", "Picasso", "Michelangelo"],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      questionEn: "What is the chemical symbol for gold?",
      questionTr: "Altının kimyasal sembolü nedir?",
      optionsEn: ["Ag", "Fe", "Au", "Cu"],
      optionsTr: ["Ag", "Fe", "Au", "Cu"],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionEn: "Which country is known as the Land of the Rising Sun?",
      questionTr: "Hangi ülke Güneş'in Doğduğu Ülke olarak bilinir?",
      optionsEn: ["China", "Korea", "Thailand", "Japan"],
      optionsTr: ["Çin", "Kore", "Tayland", "Japonya"],
      correctAnswerIndex: 3,
    ),
    QuizQuestion(
      questionEn: "What is the fastest land animal?",
      questionTr: "En hızlı kara hayvanı hangisidir?",
      optionsEn: ["Lion", "Cheetah", "Gazelle", "Leopard"],
      optionsTr: ["Aslan", "Çita", "Ceylan", "Leopar"],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      questionEn: "Which element is most abundant in Earth's atmosphere?",
      questionTr: "Dünya atmosferinde en çok bulunan element hangisidir?",
      optionsEn: ["Oxygen", "Carbon", "Nitrogen", "Hydrogen"],
      optionsTr: ["Oksijen", "Karbon", "Azot", "Hidrojen"],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionEn: "What is the largest organ in the human body?",
      questionTr: "İnsan vücudundaki en büyük organ hangisidir?",
      optionsEn: ["Heart", "Brain", "Liver", "Skin"],
      optionsTr: ["Kalp", "Beyin", "Karaciğer", "Deri"],
      correctAnswerIndex: 3,
    ),
    QuizQuestion(
      questionEn: "Which year did World War II end?",
      questionTr: "İkinci Dünya Savaşı hangi yılda sona erdi?",
      optionsEn: ["1943", "1944", "1945", "1946"],
      optionsTr: ["1943", "1944", "1945", "1946"],
      correctAnswerIndex: 2,
    ),
  ];
  final BaseDialogModel dialogModel = const BaseDialogModel();

  List<QuizQuestion> _currentQuestions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  int _lastScore = 0;
  bool _isAnimating = false;

  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late ConfettiController confettiController;

  // Getters
  List<QuizQuestion> get currentQuestions => _currentQuestions;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  int get lastScore => _lastScore;
  bool get isAnimating => _isAnimating;
  double get progressValue =>
      (_currentQuestionIndex + 1) / _currentQuestions.length.toDouble();
  bool get isQuizCompleted =>
      _currentQuestionIndex >= _currentQuestions.length - 1;

  // UI Constants
  final gradientColors = [Colors.blue.shade900, Colors.purple.shade900];
  final questionFontSize = 24.0;
  final scoreFontSize = 18.0;
  final optionFontSize = 18.0;

  QuizViewModel() {
    _initialize();
  }

  Future<void> _initialize() async {
    await _loadLastScore();
    notifyListeners();
  }

  @override
  void dispose() {
    disposeAnimations();
    super.dispose();
  }

  void disposeAnimations() {
    animationController.dispose();
    confettiController.dispose();
  }

  Future<void> _loadLastScore() async {
    final prefs = await SharedPreferences.getInstance();
    _lastScore = prefs.getInt('lastScore') ?? 0;
  }

  Future<void> _saveLastScore() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastScore', _score);
    _lastScore = _score;
  }

  void _shuffleQuestions() {
    _currentQuestions = List.from(_questions);
    _currentQuestions.shuffle();
    notifyListeners();
  }

  Future<void> _playSound(bool isCorrect) async {
    // TODO:
  }

  void startNewQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    _shuffleQuestions();
    notifyListeners();
  }

  Future<bool> checkAnswer(int selectedIndex) async {
    if (_isAnimating) return false;
    _isAnimating = true;
    notifyListeners();

    final isCorrect = selectedIndex ==
        _currentQuestions[_currentQuestionIndex].correctAnswerIndex;

    if (isCorrect) {
      _score += AppConstants.correctAnswerScore.toInt();
      playConfetti();
      await _playSound(true);

      if (_currentQuestionIndex < _currentQuestions.length - 1) {
        await animateToNextQuestion();
        _currentQuestionIndex++;
        await _saveLastScore();
        notifyListeners();
      } else {
        await _saveLastScore();
        showSuccessDialog();
      }
    } else {
      await _playSound(false);
      showFailureDialog();
    }

    _isAnimating = false;
    notifyListeners();
    return isCorrect;
  }

  void setAnimating(bool value) {
    _isAnimating = value;
    notifyListeners();
  }

  void navigateToHome() {
    if (GlobalContext.instance.hasContext) {
      Navigator.of(GlobalContext.instance.currentContext!)
          .pushNamedAndRemoveUntil(AppRouter.home, (_) => false);
    }
  }

  void showSuccessDialog() {
    if (GlobalContext.instance.hasContext) {
      final context = GlobalContext.instance.currentContext!;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          backgroundColor: context.successColor.withOpacity(0.9),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.emoji_events, size: 80, color: Colors.amber),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.translate('congratulations'),
                style: context.heading2.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!
                    .translate('final_score', [_score.toString()]),
                style: context.scoreText,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => navigateToHome(),
                child: Text(
                  AppLocalizations.of(context)!.translate('back_to_home'),
                  style: context.buttonText,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  void showFailureDialog() {
    if (GlobalContext.instance.hasContext) {
      final context = GlobalContext.instance.currentContext!;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          backgroundColor: context.errorColor.withOpacity(0.9),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.close_rounded, size: 80, color: context.errorColor),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.translate('wrong_answer'),
                style: context.heading2.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  startNewQuiz();
                },
                child: Text(
                  AppLocalizations.of(context)!.translate('try_again'),
                  style: context.buttonText,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  void initializeAnimations(TickerProvider vsync) {
    animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 600),
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOutBack,
      ),
    );

    confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
  }

  Future<void> animateToNextQuestion() async {
    await animationController.forward();
    await Future.delayed(const Duration(milliseconds: 100));
    await animationController.reverse();
  }

  void playConfetti() {
    confettiController.play();
  }
}
