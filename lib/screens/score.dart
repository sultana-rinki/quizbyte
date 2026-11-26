import 'package:flutter/material.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Score')),
      body: const Center(
        child: Text('Your Score: 8/10'),
      ),
    );
  }
}