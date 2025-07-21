import 'package:flutter/material.dart';
import '../data/sample_questions.dart';
import '../models/question.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  final bool isDarkTheme;
  final Function(bool) onThemeToggle;

  const HomeScreen({
    super.key,
    required this.isDarkTheme,
    required this.onThemeToggle,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedDifficulty = 'Easy';

  void startQuiz() {
    // Filter questions by selected difficulty
    List<Question> filtered = sampleQuestions
    .where((q) =>
        (q.difficulty ?? '').toLowerCase() ==
        selectedDifficulty.toLowerCase())
    .toList();


    // Shuffle to get random questions each time
    filtered.shuffle();

    // Take first 10 from shuffled list
    List<Question> selectedQuestions = filtered.take(10).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuizScreen(
          questions: selectedQuestions,
          difficulty: selectedDifficulty,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
        actions: [
          Row(
            children: [
              const Icon(Icons.light_mode),
              Switch(
                value: widget.isDarkTheme,
                onChanged: widget.onThemeToggle,
              ),
              const Icon(Icons.dark_mode),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose Difficulty:',
              style: TextStyle(fontSize: 18),
            ),
            DropdownButton<String>(
              value: selectedDifficulty,
              items: ['Easy', 'Medium', 'Hard']
                  .map((level) => DropdownMenuItem(
                        value: level,
                        child: Text(level),
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedDifficulty = val!;
                });
              },
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: startQuiz,
                child: const Text('Start Quiz'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
