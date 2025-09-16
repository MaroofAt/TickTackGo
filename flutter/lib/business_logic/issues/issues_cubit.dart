import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:pr1/core/constance/colors.dart';

import '../../core/API/issues.dart';
import '../../core/variables/api_variables.dart';
import '../../core/variables/global_var.dart';
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
    } on Exception catch (e) {
      emit(IssueError(e.toString()));
    }
  }

  void updateIssueSolvedLocally(int issueId) {
    if (state is IssueLoaded) {
      final currentIssues = (state as IssueLoaded).issues;

      final updatedIssues = currentIssues.map((issue) {
        if (issue.id == issueId) {
          return issue.copyWith(solved: true);
        }
        return issue;
      }).toList();

      emit(IssueLoaded(updatedIssues));
    }
  }

  // Future<void> fetchSingleIssue({
  //   required int issueId,
  //   required int projectId,
  // }) async {
  //   emit(IssueLoading());
  //   try {
  //     final issueData = await _issueApi.RetrieveIssue(
  //       issueId: issueId,
  //       projectId: projectId,
  //     );
  //
  //     emit(IssueLoadedSingle(issueData));
  //   } catch (e) {
  //     emit(IssueError(e.toString()));
  //   }
  // }

//   Future<void> makesolved({
//     required int issueId,
//     required int projectId,
//     required BuildContext context
//   }) async {
//     emit(IssueLoading());
//     try {
//       final issueData = await _issueApi.marksolved(
//         issueID: issueId, projectId: projectId, context: context,
//       );
//       emit(IssuesolvedLoaded());
//     } catch (e) {
//       emit(IssueError(e.toString()));
//     }
//   }
// }
  Future<void> marksolved({
    required BuildContext context,
    required int issueID,
    required int projectId,
  }) async {
    try {
      final response = await dio.get(
        '/issues/$issueID/mark_issue_as_solved/',
        data: {
          "issue": issueID,
          "project": projectId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'accept': 'application/json',
            'Content-Type': 'application/json',
          },

          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {

        emit(IssuesolvedLoaded());
        fetchSingleIssue(
          issueId: issueID,
          projectId: projectId,
        );

        showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: const Text("Success"),
                content: const Text(
                    "The issue was marked as solved successfully ✅",style: TextStyle(color: white),),
                actions: [
                  TextButton(
                    child: const Text("OK"),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
        );
      } else if (response.statusCode == 400) {
        final errorMessage = response.data?["message"];


        if (errorMessage.toString().toLowerCase().contains("already solved")) {


          showDialog(
            context: context,
            builder: (_) =>
                AlertDialog(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  title: const Text("Notice"),
                  content: const Text("This issue is already solved.",style: TextStyle(color: white),),
                  actions: [
                    TextButton(
                      child: const Text("OK"),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
          );
          emit(IssuesolvedLoaded());
          fetchSingleIssue(
            issueId: issueID,
            projectId: projectId,
          );
        } else {

          emit(IssueError(errorMessage));

          showDialog(
            context: context,
            builder: (_) =>
                AlertDialog(
                  title: const Text("Error"),
                  content: Text("Dio error: $errorMessage",style: TextStyle(color: white)),
                  actions: [
                    TextButton(
                      child: const Text("OK"),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
          );
        }
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data?["message"] ?? e.message;

      emit(IssueError(errorMessage));

      showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(
              title: const Text("Notice"),
              content: Text(
                errorMessage.toString().toLowerCase().contains("already solved")
                    ? "This issue is already solved."
                    : "Dio error: $errorMessage",
                  style: TextStyle(color: white)
              ),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
      );
    } catch (e) {
      emit(IssueError(e.toString()));

      showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(
              title: const Text("Unexpected Error"),
              content: Text("Something went wrong: $e",style: TextStyle(color: white)),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
      );
    }
  }
}
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
