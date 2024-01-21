import 'package:flutter/material.dart';
import 'package:quiz_app/models/question_with_answer.dart';
import 'package:quiz_app/utils/app_colors.dart';
import 'package:quiz_app/widgets/answer_widget_item.dart';
import 'package:quiz_app/widgets/congrats_widgets.dart';
import 'package:quiz_app/widgets/main_button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int questionIndex = 0;
  bool isFinished = false;
  int score = 0;
  String? selectedAnswer;
  bool Validation = false;
  bool showAnswers = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: !isFinished
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        questionsWithAnswers[questionIndex].question,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      !Validation ? 
                      const Text(
                        'Answer and get points!',
                        style: TextStyle(
                          fontSize: 17,
                          color: AppColors.grey,
                        ),
                      ) : const Text(
                        'Please choose an Answer!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.red,
                              ),
                            ),
                      const SizedBox(height: 36),
                      Column(
                        children: questionsWithAnswers[questionIndex]
                            .answers
                            .map((answer) => AnswerWidgetItem(
                                  answer: answer,
                                  selectedAnswer: selectedAnswer,
                                  onTap: () {
                                    setState(() {
                                      selectedAnswer = answer.text;
                                    });
                                  },
                                ))
                            .toList(),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MainButton(
                            text: 'Previous',
                            onTap: () {
                              setState(() {
                                if (questionIndex > 0) {
                                  questionIndex--;
                                }
                                selectedAnswer = null;
                                Validation = false;
                              });
                            },
                          ),
                          MainButton(
                            text: 'Next',
                            onTap: () {
                              setState(() {
                                final questionObj =
                                    questionsWithAnswers[questionIndex];
                                if (selectedAnswer == null) {
                                  setState(() {
                                    Validation = true;
                                  });
                                  return;
                                } else {
                                  setState(() {
                                    Validation = false;
                                  });
                                }

                                if (selectedAnswer ==
                                    questionObj.correctAnswer) {
                                  score++;
                                }

                                if (questionIndex <
                                    questionsWithAnswers.length - 1) {
                                  questionIndex++;
                                  selectedAnswer = null;
                                } else {
                                  isFinished = true;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  )
                : Column(
                  children: [
                    CongratsWidgets(
                        score: score,
                        onTap: () {
                          setState(() {
                            questionIndex = 0;
                            isFinished = false;
                            score = 0;
                            selectedAnswer = null;
                            Validation = false;
                            showAnswers = false;
                          });
                        },
                        viewAnswers: () {
                          setState(() {
                            showAnswers = true;
                          });
                        },
                      ),
                      
                      if (showAnswers)
                        Column(
                          children: questionsWithAnswers
                              .map((q) => AnswerWidgetItem(
                                    answer: Answer(text: q.correctAnswer, icon: Icons.check),
                                    selectedAnswer: selectedAnswer,
                                    onTap: () {},
                                  ))
                              .toList(),
                        ),
                  ],
                ),
                  
          ),
        ),
      ),
    );
  }
}
