part of 'comment_cubit.dart';

@immutable
sealed class CommentState {}

final class CommentInitial extends CommentState {}

final class CommentLoading extends CommentState {}

final class CommentSending extends CommentState {}

final class CommentLoaded extends CommentState {
  final List<Comment> comments;
  CommentLoaded(this.comments);
}

final class CommentError extends CommentState {
  final String message;
  CommentError(this.message);
}
