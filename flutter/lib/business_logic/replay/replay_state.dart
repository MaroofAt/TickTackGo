import '../../data/models/issues/showreplie.dart';
abstract class ReplyState {}

class ReplyInitial extends ReplyState {}

class ReplyLoading extends ReplyState {}

class ReplyLoaded extends ReplyState {
  final List<ShowReplie> replies;
  ReplyLoaded(this.replies);
}

class ReplyError extends ReplyState {
  final String message;
  ReplyError(this.message);
}

class ReplyCreating extends ReplyState {}

class ReplyCreated extends ReplyState {}
