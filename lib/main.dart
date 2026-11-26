
import 'dart:async';
import 'package:flutter/material.dart';

import 'models/quiz_question.dart';
import 'data/bangla_questions.dart';
import 'data/english_questions.dart';
import 'data/gk_questions.dart';
import 'data/science_questions.dart';
import 'data/technology_questions.dart';
import 'data/sports_questions.dart';
import 'data/mathematics_questions.dart';
import 'screens/about_page.dart';
import 'screens/score.dart';

void main() {
  runApp(const QuizByteApp());
}

class QuizByteApp extends StatelessWidget {
  const QuizByteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuizByte',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2563EB),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const HomePage(),
    );
  }
}

// HOME SCREEN
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();

  String selectedCategory = 'Bangla';
  String selectedDifficulty = 'Easy';

  final Map<String, List<QuizQuestion>> categoryQuestions = {
    'Bangla': banglaQuestions,
    'English': englishQuestions,
    'General Knowledge': gkQuestions,
    'Science': scienceQuestions,
    'Technology': technologyQuestions,
    'Sports': sportsQuestions,
    'Mathematics': mathematicsQuestions,
  };

  List<String> get categories => categoryQuestions.keys.toList();

  final difficulties = ['Easy', 'Medium', 'Hard'];

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void startQuiz() {
    final name = nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your name first!'),
        ),
      );
      return;
    }

    final questions = categoryQuestions[selectedCategory] ?? [];
    if (questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No questions available in this category yet.'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuizPage(
          name: name,
          category: selectedCategory,
          difficulty: selectedDifficulty,
          questions: List<QuizQuestion>.unmodifiable(questions),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'QuizByte',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon( Icons.emoji_events),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ScorePage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'About QuizByte',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AboutPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(26),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF2563EB),
                        Color(0xFF60A5FA),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.psychology_rounded,
                        color: Colors.white,
                        size: 68,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Welcome to QuizByte!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Challenge yourself. Learn something new.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                Card(
                  elevation: 0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Set Up Your Quiz',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'Your Name',
                            prefixIcon: Icon(Icons.person_outline),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 18),
                        DropdownButtonFormField<String>(
                          initialValue: selectedCategory,
                          isExpanded: true,
                          decoration: const InputDecoration(
                            labelText: 'Quiz Category',
                            prefixIcon: Icon(Icons.category_outlined),
                            border: OutlineInputBorder(),
                          ),
                          items: categories.map((category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                selectedCategory = value;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 18),
                        DropdownButtonFormField<String>(
                          initialValue: selectedDifficulty,
                          decoration: const InputDecoration(
                            labelText: 'Difficulty Level',
                            prefixIcon: Icon(Icons.speed),
                            border: OutlineInputBorder(),
                          ),
                          items: difficulties.map((difficulty) {
                            return DropdownMenuItem(
                              value: difficulty,
                              child: Text(difficulty),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                selectedDifficulty = value;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 18),
                        const Row(
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              color: Colors.blue,
                            ),
                            SizedBox(width: 8),
                            Text('Quiz Duration: 5 minutes'),
                          ],
                        ),
                        const SizedBox(height: 24),
                        FilledButton.icon(
                          onPressed: startQuiz,
                          icon: const Icon(Icons.play_arrow_rounded),
                          label: const Text('Start Quiz'),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                            textStyle: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Learn • Practice • Improve',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// QUIZ SCREEN
class QuizPage extends StatefulWidget {
  final List<QuizQuestion> questions;
  final String name;
  final String category;
  final String difficulty;

  const QuizPage({
    super.key,
    required this.name,
    required this.category,
    required this.difficulty,
    required this.questions,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  static const int quizDuration = 300;

  int currentQuestion = 0;
  int remainingSeconds = quizDuration;
  Timer? timer;
  bool submitted = false;

  late final List<int?> selectedAnswers;

  @override
  void initState() {
    super.initState();
    selectedAnswers =
    List<int?>.filled(widget.questions.length, null);
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        if (!mounted || submitted) {
          timer.cancel();
          return;
        }

        if (remainingSeconds > 1) {
          setState(() {
            remainingSeconds--;
          });
        } else {
          setState(() {
            remainingSeconds = 0;
          });
          submitQuiz(timeExpired: true);
        }
      },
    );
  }

  String get formattedTime {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  void submitQuiz({bool timeExpired = false}) {
    if (submitted) return;

    submitted = true;
    timer?.cancel();

    int score = 0;

    for (int i = 0; i < widget.questions.length; i++) {
      if (selectedAnswers[i] ==
          widget.questions[i].correctAnswer) {
        score++;
      }
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultPage(
          name: widget.name,
          category: widget.category,
          difficulty: widget.difficulty,
          score: score,
          questions: widget.questions,
          selectedAnswers: List<int?>.from(selectedAnswers),
          timeExpired: timeExpired,
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestion];
    final answeredCount =
        selectedAnswers.where((answer) => answer != null).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('QuizByte Quiz'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: remainingSeconds <= 60
                      ? Colors.red.shade50
                      : Colors.blue.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Time Remaining',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.timer,
                              color: remainingSeconds <= 60
                                  ? Colors.red
                                  : Colors.blue,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              formattedTime,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: remainingSeconds <= 60
                                    ? Colors.red
                                    : Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Player: ${widget.name}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${widget.category} • ${widget.difficulty}',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),
                Text(
                  'Question ${currentQuestion + 1} of '
                      '${widget.questions.length}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value: (currentQuestion + 1) /
                      widget.questions.length,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(10),
                ),
                const SizedBox(height: 10),
                Text(
                  '$answeredCount of '
                      '${widget.questions.length} answered',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 25),
                Text(
                  question.question,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: ListView.builder(
                    itemCount: question.options.length,
                    itemBuilder: (context, index) {
                      final isSelected =
                          selectedAnswers[currentQuestion] == index;

                      return Card(
                        color: isSelected
                            ? Colors.blue.shade50
                            : Colors.white,
                        child: RadioListTile<int>(
                          title: Text(question.options[index]),
                          value: index,
                          groupValue:
                          selectedAnswers[currentQuestion],
                          onChanged: (value) {
                            setState(() {
                              selectedAnswers[currentQuestion] =
                                  value;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    if (currentQuestion > 0)
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            currentQuestion--;
                          });
                        },
                        child: const Text('Previous'),
                      ),
                    const Spacer(),
                    if (currentQuestion <
                        widget.questions.length - 1)
                      FilledButton(
                        onPressed: () {
                          setState(() {
                            currentQuestion++;
                          });
                        },
                        child: const Text('Next'),
                      )
                    else
                      FilledButton(
                        onPressed: () => submitQuiz(),
                        child: const Text('Submit Quiz'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// RESULT SCREEN
class ResultPage extends StatelessWidget {
  final String name;
  final String category;
  final String difficulty;
  final int score;
  final List<QuizQuestion> questions;
  final List<int?> selectedAnswers;
  final bool timeExpired;

  const ResultPage({
    super.key,
    required this.name,
    required this.category,
    required this.difficulty,
    required this.score,
    required this.questions,
    required this.selectedAnswers,
    required this.timeExpired,
  });

  @override
  Widget build(BuildContext context) {
    final total = questions.length;
    final percentage = score / total * 100;

    final wrong = selectedAnswers.asMap().entries
        .where((entry) =>
    entry.value != null &&
        entry.value != questions[entry.key].correctAnswer)
        .length;

    final skipped =
        selectedAnswers.where((answer) => answer == null).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Result'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Column(
              children: [
                Icon(
                  timeExpired
                      ? Icons.timer_off
                      : Icons.emoji_events,
                  color: timeExpired
                      ? Colors.red
                      : Colors.orange,
                  size: 80,
                ),
                const SizedBox(height: 16),
                Text(
                  timeExpired
                      ? 'Time is Up!'
                      : 'Quiz Completed!',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text('Well done, $name!'),
                const SizedBox(height: 10),
                Text('$category • $difficulty'),
                const SizedBox(height: 25),
                Text(
                  '$score / $total',
                  style: const TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const Text('Your Score'),
                const SizedBox(height: 12),
                Text(
                  '${percentage.toStringAsFixed(1)}%',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text(
                          'Performance Analysis',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text('Correct Answers: $score'),
                        Text('Wrong Answers: $wrong'),
                        Text('Skipped Answers: $skipped'),
                        Text(
                          'Accuracy: '
                              '${percentage.toStringAsFixed(1)}%',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ReviewPage(
                            questions: questions,
                            selectedAnswers: selectedAnswers,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.fact_check),
                    label: const Text('Review Answers'),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.popUntil(
                        context,
                            (route) => route.isFirst,
                      );
                    },
                    icon: const Icon(Icons.home),
                    label: const Text('Back to Home'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// REVIEW ANSWERS
class ReviewPage extends StatelessWidget {
  final List<QuizQuestion> questions;
  final List<int?> selectedAnswers;

  const ReviewPage({
    super.key,
    required this.questions,
    required this.selectedAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Answers'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final question = questions[index];
              final selected = selectedAnswers[index];
              final isCorrect =
                  selected == question.correctAnswer;

              return Card(
                margin: const EdgeInsets.only(bottom: 14),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Q${index + 1}. ${question.question}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Your Answer: '
                            '${selected == null ? "Not Answered" : question.options[selected]}',
                        style: TextStyle(
                          color: isCorrect
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Correct Answer: '
                            '${question.options[question.correctAnswer]}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isCorrect
                            ? 'Correct'
                            : selected == null
                            ? 'Skipped'
                            : 'Incorrect',
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
