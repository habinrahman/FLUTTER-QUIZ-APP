import 'package:flutter/material.dart';
import '../models/question.dart';

class ResultScreen extends StatefulWidget {
  final List<Question> questions;
  final Map<int, int> selectedAnswers;

  const ResultScreen({
    super.key,
    required this.questions,
    required this.selectedAnswers,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool showAnswers = false;

  int calculateScore() {
    int score = 0;
    for (int i = 0; i < widget.questions.length; i++) {
      if (widget.selectedAnswers[i] == widget.questions[i].correctAnswerIndex) {
        score++;
      }
    }
    return score;
  }

  @override
  Widget build(BuildContext context) {
    final int score = calculateScore();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You scored $score out of ${widget.questions.length}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showAnswers = true;
                });
              },
              child: const Text('Review Answers'),
            ),
            const SizedBox(height: 20),
            if (showAnswers)
              Expanded(
                child: ListView.builder(
                  itemCount: widget.questions.length,
                  itemBuilder: (context, index) {
                    final question = widget.questions[index];
                    final selectedIndex = widget.selectedAnswers[index];
                    final isCorrect = selectedIndex == question.correctAnswerIndex;

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Q${index + 1}: ${question.questionText}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Your Answer: ${selectedIndex != null ? question.options[selectedIndex] : "No answer"}',
                              style: TextStyle(
                                color: isCorrect ? Colors.green : Colors.red,
                              ),
                            ),
                            Text(
                              'Correct Answer: ${question.options[question.correctAnswerIndex]}',
                              style: const TextStyle(color: Colors.green),
                            ),
                            if (question.explanation != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                'Explanation: ${question.explanation}',
                                style: const TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            if (!showAnswers)
              const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Home'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
