import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/core/variables/intro_questions_variables.dart';

part 'intro_questions_state.dart';

class IntroQuestionsCubit extends Cubit<IntroQuestionsState> {
  IntroQuestionsCubit() : super(IntroQuestionsInitial());

  void nextQuestion() {
    emit(RefreshState());
    if (selectedOption.isEmpty) return;
    if (currentQuestionIndex < introQuestions.length - 1) {
      currentQuestionIndex++;
      selectedOption = '';
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCirc,
      );
      emit(RefreshedState());
    } else {
      emit(QuestionsFinishedState());
    }
  }

  void previousQuestion() {
    emit(RefreshState());
    if (currentQuestionIndex != 0) {
      pageController.animateToPage(
        currentQuestionIndex - 1,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOutBack,
      );
      currentQuestionIndex--;
    }
    emit(RefreshedState());
  }
}
