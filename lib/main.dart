
import 'package:flutter/material.dart';

void main() {
  runApp(const QuizByteApp());
}

// MAIN APPLICATION
class QuizByteApp extends StatelessWidget {
  const QuizByteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuizByte',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const HomePage(),
    );
  }
}

// QUESTION MODEL
class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswer;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}

// SAMPLE QUESTION BANK
const List<QuizQuestion> sampleQuestions = [
  QuizQuestion(
    question: 'What is the capital of Bangladesh?',
    options: ['Chittagong', 'Dhaka', 'Sylhet', 'Khulna'],
    correctAnswer: 1,
  ),
  QuizQuestion(
    question: 'Which planet is known as the Red Planet?',
    options: ['Venus', 'Jupiter', 'Mars', 'Saturn'],
    correctAnswer: 2,
  ),
  QuizQuestion(
    question: 'How many days are there in a leap year?',
    options: ['365', '364', '366', '360'],
    correctAnswer: 2,
  ),
  QuizQuestion(
    question: 'Which programming language is used by Flutter?',
    options: ['Java', 'Python', 'Dart', 'C++'],
    correctAnswer: 2,
  ),
  QuizQuestion(
    question: 'What is 12 × 8?',
    options: ['84', '96', '108', '88'],
    correctAnswer: 1,
  ),
];

// HOME PAGE
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController nameController =
  TextEditingController();

  String selectedCategory = 'General Knowledge';
  String selectedDifficulty = 'Easy';

  final List<String> categories = [
    'General Knowledge',
    'Science',
    'Technology',
    'Sports',
    'Mathematics',
  ];

  final List<String> difficulties = [
    'Easy',
    'Medium',
    'Hard',
  ];

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
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizPage(
          name: name,
          category: selectedCategory,
          difficulty: selectedDifficulty,
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
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.quiz_rounded,
                  size: 80,
                  color: Colors.blue,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Welcome to QuizByte!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Test your knowledge and improve your skills.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 30),

                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Your Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                DropdownButtonFormField<String>(
                  initialValue: selectedCategory,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Select Quiz Category',
                    prefixIcon: Icon(Icons.category),
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

                const SizedBox(height: 20),

                DropdownButtonFormField<String>(
                  initialValue: selectedDifficulty,
                  decoration: const InputDecoration(
                    labelText: 'Select Difficulty Level',
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

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: startQuiz,
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text('Start Quiz'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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

// QUIZ PAGE
class QuizPage extends StatefulWidget {
  final String name;
  final String category;
  final String difficulty;

  const QuizPage({
    super.key,
    required this.name,
    required this.category,
    required this.difficulty,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestion = 0;

  final List<int?> selectedAnswers =
  List<int?>.filled(sampleQuestions.length, null);

  void nextQuestion() {
    if (currentQuestion < sampleQuestions.length - 1) {
      setState(() {
        currentQuestion++;
      });
    }
  }

  void previousQuestion() {
    if (currentQuestion > 0) {
      setState(() {
        currentQuestion--;
      });
    }
  }

  void submitQuiz() {
    int score = 0;

    for (int i = 0; i < sampleQuestions.length; i++) {
      if (selectedAnswers[i] ==
          sampleQuestions[i].correctAnswer) {
        score++;
      }
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          name: widget.name,
          category: widget.category,
          difficulty: widget.difficulty,
          score: score,
          questions: sampleQuestions,
          selectedAnswers: List<int?>.from(selectedAnswers),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = sampleQuestions[currentQuestion];
    final answeredCount =
        selectedAnswers.where((answer) => answer != null).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('QuizByte Quiz'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Player: ${widget.name}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${widget.category} • ${widget.difficulty}',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),

                Text(
                  'Question ${currentQuestion + 1} of '
                      '${sampleQuestions.length}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                LinearProgressIndicator(
                  value: (currentQuestion + 1) /
                      sampleQuestions.length,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(10),
                ),

                const SizedBox(height: 12),

                Text(
                  '$answeredCount of '
                      '${sampleQuestions.length} answered',
                  style: const TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 30),

                Text(
                  question.question,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: ListView.builder(
                    itemCount: question.options.length,
                    itemBuilder: (context, index) {
                      final isSelected =
                          selectedAnswers[currentQuestion] ==
                              index;

                      return Card(
                        color: isSelected
                            ? Colors.blue.shade50
                            : Colors.white,
                        child: RadioListTile<int>(
                          title: Text(question.options[index]),
                          value: index,
                          // Uses RadioListTile's existing API.
                          // May show a deprecation warning
                          // on newer Flutter versions.
                          groupValue:
                          selectedAnswers[currentQuestion],
                          activeColor: Colors.blue,
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

                const SizedBox(height: 10),

                Row(
                  children: [
                    if (currentQuestion > 0)
                      ElevatedButton.icon(
                        onPressed: previousQuestion,
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Previous'),
                      ),

                    const Spacer(),

                    if (currentQuestion <
                        sampleQuestions.length - 1)
                      ElevatedButton.icon(
                        onPressed: nextQuestion,
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text('Next'),
                      )
                    else
                      ElevatedButton.icon(
                        onPressed: submitQuiz,
                        icon: const Icon(Icons.check),
                        label: const Text('Submit'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
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

// RESULT PAGE
class ResultPage extends StatelessWidget {
  final String name;
  final String category;
  final String difficulty;
  final int score;
  final List<QuizQuestion> questions;
  final List<int?> selectedAnswers;

  const ResultPage({
    super.key,
    required this.name,
    required this.category,
    required this.difficulty,
    required this.score,
    required this.questions,
    required this.selectedAnswers,
  });

  @override
  Widget build(BuildContext context) {
    final total = questions.length;
    final percentage = score / total * 100;
    final wrongAnswers = selectedAnswers.asMap().entries
        .where((entry) =>
    entry.value != null &&
        entry.value != questions[entry.key].correctAnswer)
        .length;
    final skippedAnswers =
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
            constraints: const BoxConstraints(maxWidth: 450),
            child: Column(
              children: [
                const Icon(
                  Icons.emoji_events,
                  size: 90,
                  color: Colors.orange,
                ),
                const SizedBox(height: 16),

                const Text(
                  'Quiz Completed!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  'Well done, $name!',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),

                Text('$category • $difficulty'),

                const SizedBox(height: 25),

                Text(
                  '$score / $total',
                  style: const TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),

                const Text(
                  'Your Score',
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 12),

                Text(
                  '${percentage.toStringAsFixed(1)}%',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                Card(
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
                        const SizedBox(height: 15),
                        Text('Correct Answers: $score'),
                        Text('Wrong Answers: $wrongAnswers'),
                        Text('Skipped Answers: $skippedAnswers'),
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
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReviewPage(
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

// ANSWER REVIEW PAGE
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

              final selectedText = selected == null
                  ? 'Not Answered'
                  : question.options[selected];

              final correctText =
              question.options[question.correctAnswer];

              return Card(
                margin: const EdgeInsets.only(bottom: 15),
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
                        'Your Answer: $selectedText',
                        style: TextStyle(
                          color: isCorrect
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        'Correct Answer: $correctText',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          Icon(
                            isCorrect
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: isCorrect
                                ? Colors.green
                                : Colors.red,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isCorrect
                                ? 'Correct'
                                : selected == null
                                ? 'Skipped'
                                : 'Incorrect',
                          ),
                        ],
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
