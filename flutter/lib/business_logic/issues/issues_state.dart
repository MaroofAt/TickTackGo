part of 'issues_cubit.dart';

@immutable
sealed class IssuesState {}

final class IssuesInitial extends IssuesState {}
class IssueInitial extends IssuesState {}

class IssueLoading extends IssuesState {}

class IssueCreating extends IssuesState {}

class IssueLoaded extends IssuesState {
   List<ListIssuesModel> issues;
  IssueLoaded(this.issues);
}

class IssuesolvedLoaded extends IssuesState {
}
class IssueCreated extends IssuesState {
  // final ListIssuesModel issue;
  // IssueCreated(this.issue);
}

class IssueError extends IssuesState {
  final String message;
  IssueError(this.message);
}
class IssueLoadedSingle extends IssuesState {
  final ListIssuesModel issue;
  IssueLoadedSingle(this.issue);
}
// class ReplyLoading extends IssuesState {}
// class ReplyLoaded extends IssuesState {
//   final List<ShowReplie> replies;
//   ReplyLoaded(this.replies);
// }
// class ReplyCreating extends IssuesState {}
// class ReplyCreated extends IssuesState {}