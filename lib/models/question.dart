// lib/models/question.dart
class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final String? difficulty;
  final String? category;
  final String? explanation;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    this.difficulty,
    this.category,
    this.explanation,
  });
}
