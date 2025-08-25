import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../core/API/issues.dart';
import '../../core/variables/issues_variables.dart';
import '../../data/models/issues/issue_create.dart';
import '../../data/models/issues/list_issues_model.dart';
import '../../data/models/issues/showreplie.dart';

part 'issues_state.dart';

class IssuesCubit extends Cubit<IssuesState> {
  final IssueApi _issueApi;

  IssuesCubit(this._issueApi) : super(IssuesInitial());

  Future<void> fetchIssues(int projectId) async {
    emit(IssueLoading());
    try {
      final issues = await _issueApi.get_All_Issues(projectId: projectId);
      emit(IssueLoaded(issues));
    } catch (e) {
      emit(IssueError(e.toString()));
    }
  }

  // void addIssue(IssueModel issue) {
  //   if (state is IssueLoaded) {
  //     final currentIssues = List<IssueModel>.from((state as IssueLoaded).issues);
  //     currentIssues.add(issue);
  //     emit(IssueLoaded(issues: currentIssues));
  //   }
  // }

  Future<void> createIssue({
    required String title,
    required String description,
    required int projectId,
  }) async
  {
    emit(IssueCreating());
    try {
      await _issueApi.createIssue(
        title: title,
        description: description,
        projectId: projectId,
      );
      emit(IssueCreated());
    } catch (e) {
      emit(IssueError(e.toString()));
    }
  }


  Future<void> fetchSingleIssue({
    required int issueId,
    required int projectId,
  }) async {
    emit(IssueLoading());
    try {
      final issueData = await _issueApi.RetrieveIssue(
        issueId: issueId,
        projectId: projectId,
      );

      emit(IssueLoadedSingle(issueData));

    } catch (e) {
      emit(IssueError(e.toString()));
    }
  }}
  // Future<void> fetchReplies(int projectId, int issueId) async {
  //   emit(ReplyLoading());
  //   try {
  //     final replies = await _issueApi.get_Replie(projectId: projectId, issueID: issueId);
  //     emit(ReplyLoaded(replies));
  //   } catch (e) {
  //     emit(IssueError(e.toString()));
  //   }
  // }

//   Future<void> createReply({
//     required String body,
//     required int issueId,
//   }) async {
//     emit(ReplyCreating());
//     try {
//       await _issueApi.createReplie(
//         body: body,
//         issueID: issueId,
//       );
//       emit(ReplyCreated());
//     } catch (e) {
//       emit(IssueError(e.toString()));
//     }
//   }
// }
//
//
