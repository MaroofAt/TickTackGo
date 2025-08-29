
import 'package:flutter/material.dart';
import 'package:pr1/data/models/local_models/intro_questions_model.dart';

final PageController introQuestionsPageController = PageController();

int currentQuestionIndex = 0;
String selectedOption = '';
List<String> selectedOptions = [
  '',
  '',
  ''
];


List<IntroQuestionsModel> introQuestions = [
  IntroQuestionsModel('What do you do?',
      {
    'Software/IT': 'software_or_it',
    'HR/operations': 'hr_or_operations',
    'Sales \$ marketing': 'sales_and_marketing',
    'Education': 'education',
    'Finance': 'finance',
    'Health': 'healthhealth',
    'Student': 'student',
    'Architecture engineer': 'architecture_engineer',
    'Other': 'other',
  }),
  IntroQuestionsModel('How to use website?', {
    'Own tasks management': 'own_tasks_management',
    'Small team': 'small_team',
    'Medium team': 'medium_team',
  }),
  IntroQuestionsModel('how did you get here?', {
    'Google search': 'google_search',
    'Friends': 'friends',
    'Youtube': 'youtube',
    'Instagram': 'instagram',
    'Facebook': 'facebook',
  }),
];
