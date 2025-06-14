
import 'package:flutter/material.dart';
import 'package:pr1/data/models/intro_questions_model.dart';

final PageController introQuestionsPageController = PageController();

int currentQuestionIndex = 0;
String selectedOption = '';
List<String> selectedOptions = [
  '',
  '',
  ''
];


List<IntroQuestionsModel> introQuestions = [
  IntroQuestionsModel('What do you do?',[
    'Software/IT',
    'HR/operations',
    'Sales \$ marketing',
    'Education',
    'Finance',
    'Health',
    'Student',
    'Architecture engineer',
    'Other',
  ]),
  IntroQuestionsModel('How to use website?',[
    'Own tasks management',
    'Small team',
    'Medium company',
  ]),
  IntroQuestionsModel('how did you get here?',[
    'Google search',
    'Friends',
    'Youtube',
    'Instagram',
    'Facebook',
  ]),
];
