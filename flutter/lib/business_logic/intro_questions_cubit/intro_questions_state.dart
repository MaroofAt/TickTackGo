part of 'intro_questions_cubit.dart';

@immutable
sealed class IntroQuestionsState {}

final class IntroQuestionsInitial extends IntroQuestionsState {}

class RefreshState extends IntroQuestionsState {}

class RefreshedState extends IntroQuestionsState {}
