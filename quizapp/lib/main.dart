import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  bool isDark = false;
  void toggleTheme(bool v) => setState(() => isDark = v);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(isDarkTheme: isDark, onThemeToggle: toggleTheme),
    );
  }
}
