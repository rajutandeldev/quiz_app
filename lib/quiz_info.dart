import 'package:quiz_app/modal/question_modal.dart';

final List<Question> sampleQuestions = [
  Question(
    questionText:
        '1. What is the output of the following code?  \nconsole.log(typeof null);',
    options: ['object', 'null', 'Array', 'boolean'],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText:
        '2. Which of the following is not a valid way to declare a variable in JavaScript?',
    options: ['let', 'const', 'var', 'int'],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText:
        '3. What will the following code output? \n let x = [1, 2, 3];\nlet y = x;\ny.push(4);\nconsole.log(x);',
    options: ['[1, 2, 3]', '[1, 2, 3, 4]', 'Error', '[4, 1, 2, 3]'],
    correctAnswerIndex: 1,
  ),
];
