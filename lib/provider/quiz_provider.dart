import 'package:flutter/material.dart';
import 'package:quiz_app/modal/question_modal.dart';
import 'package:quiz_app/quiz_info.dart';

class QuizProvider extends ChangeNotifier {
  int _currentQuestionIndex = 0;
  int _score = 0;
  final List<int> _userAnswers = [];

  final List<Question> _questions = sampleQuestions;

  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  Question get currentQuestion => _questions[_currentQuestionIndex];
  bool get isQuizComplete => _currentQuestionIndex >= _questions.length;
  int get totalQuestions => _questions.length;

  int? get selectedOption => _userAnswers.length > _currentQuestionIndex
      ? _userAnswers[_currentQuestionIndex]
      : null;

  // Set the selected option
  void setSelectedOption(int selectedOptionIndex) {
    if (_userAnswers.length <= _currentQuestionIndex) {
      _userAnswers.add(selectedOptionIndex);
    } else {
      _userAnswers[_currentQuestionIndex] = selectedOptionIndex;
    }
    notifyListeners();
  }

  // Move to next question
  void nextQuestion(int selectedOptionIndex) {
    if (_userAnswers.length == _currentQuestionIndex) {
      _userAnswers.add(selectedOptionIndex);
      if (selectedOptionIndex == currentQuestion.correctAnswerIndex) {
        _score++;
      }
    }
    if (_currentQuestionIndex < _questions.length) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  // Move to previous question
  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  void next() {
    _currentQuestionIndex++;
    notifyListeners();
  }

  // Reset the quiz
  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    _userAnswers.clear();
    notifyListeners();
  }
}
