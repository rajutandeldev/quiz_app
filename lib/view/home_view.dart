import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/provider/quiz_provider.dart';
import 'package:quiz_app/provider/score_provider.dart';
import 'package:quiz_app/provider/timer_provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final timerProvider = Provider.of<TimerProvider>(context);
    final scoreProvider = Provider.of<ScoreProvider>(context);

    if (quizProvider.isQuizComplete) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quiz Complete')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Your score: ${scoreProvider.score}'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  quizProvider.resetQuiz();
                  scoreProvider.resetScore();
                  timerProvider.resetTimer();
                },
                child: const Text('Restart Quiz'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${quizProvider.currentQuestionIndex + 1}:',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              quizProvider.currentQuestion.questionText,
              style: const TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 16),
            const Text('Options are : '),
            ...quizProvider.currentQuestion.options
                .asMap()
                .entries
                .map((entry) {
              int idx = entry.key;
              String option = entry.value;
              return ListTile(
                title: Text(option),
                leading: Radio<int>(
                  value: idx,
                  groupValue: quizProvider.selectedOption,
                  onChanged: (value) {
                    quizProvider.setSelectedOption(value!);
                    if (idx ==
                        quizProvider.currentQuestion.correctAnswerIndex) {
                      scoreProvider.incrementScore();
                    }
                    setState(() {}); // Refresh state
                  },
                ),
              );
            }).toList(),
            const SizedBox(height: 16),
            // Navigation Buttons (Previous and Next)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: quizProvider.currentQuestionIndex > 0
                      ? quizProvider.previousQuestion
                      : null, // Disable button if on the first question
                  child: const Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: quizProvider.currentQuestionIndex <
                          quizProvider.totalQuestions
                      ? () => quizProvider.next()
                      : null, // Disable button if on the last question
                  child: quizProvider.currentQuestionIndex ==
                          quizProvider.totalQuestions - 1
                      ? const Text('Submit')
                      : const Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
