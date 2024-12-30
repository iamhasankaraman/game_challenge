class QuizQuestion {
  final String questionEn;
  final String questionTr;
  final List<String> optionsEn;
  final List<String> optionsTr;
  final int correctAnswerIndex;

  QuizQuestion({
    required this.questionEn,
    required this.questionTr,
    required this.optionsEn,
    required this.optionsTr,
    required this.correctAnswerIndex,
  });
}
