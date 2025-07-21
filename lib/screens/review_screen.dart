import 'package:flutter/material.dart';
import '../models/question.dart';

class ReviewScreen extends StatelessWidget {
  final List<Question> questions;
  final List<int?> selectedAnswers;

  const ReviewScreen({
    super.key,
    required this.questions,
    required this.selectedAnswers,
  });

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: Text('Review Answers')),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: questions.length,
        itemBuilder: (ctx, idx) {
          final q = questions[idx];
          final userChoice = selectedAnswers[idx];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(q.questionText, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                ...List.generate(q.options.length, (i) {
                  Color clr = Colors.black;
                  String prefix = '';
                  if (i == q.correctAnswerIndex) clr = Colors.green;
                  if (i == userChoice) {
                    clr = (userChoice == q.correctAnswerIndex) ? Colors.green : Colors.red;
                    prefix = userChoice == q.correctAnswerIndex ? '✔ ' : '✘ ';
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text('$prefix${q.options[i]}', style: TextStyle(color: clr)),
                  );
                }),
              ]),
            ),
          );
        },
      ),
    );
  }
}
