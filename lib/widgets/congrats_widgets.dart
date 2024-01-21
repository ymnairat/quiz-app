import 'package:flutter/material.dart';
import 'package:quiz_app/models/question_with_answer.dart';

class CongratsWidgets extends StatelessWidget {
  final int score;
  final VoidCallback onTap;
  final VoidCallback viewAnswers;

  const CongratsWidgets({
    super.key,
    required this.score,
    required this.onTap,
    required this.viewAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Congratulations!',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Your score: $score/${questionsWithAnswers.length}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: onTap,
          child: const Text('Reset Quiz'),
        ),
        ElevatedButton(
          onPressed: viewAnswers,
          child: const Text('View Answers'),
        ),
      ],
    );
  }
}
