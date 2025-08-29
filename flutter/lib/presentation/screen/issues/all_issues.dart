import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/issues/issues_cubit.dart';
import 'package:pr1/business_logic/issues/issues_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/variables/issues_variables.dart';

import '../../../data/models/issues/issue_create.dart';
import '../../../data/models/issues/issue_model.dart';
import 'all_list.dart';
import 'creat_issue.dart';
import 'notsolveissue.dart';
class All_Issues extends StatefulWidget {
  final int project_Id;
  const All_Issues({super.key, required this.project_Id});

  @override
  State<All_Issues> createState() => _All_IssuesState();
}

class _All_IssuesState extends State<All_Issues> {
  @override
  void initState() {
    super.initState();
     context.read<IssuesCubit>().fetchIssues(widget.project_Id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssuesCubit, IssuesState>(
      builder: (context, state) {
        if (state is IssueLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is IssueError) {
          return Center(child: Text("Error: ${state.message}"));
        }

        if (state is IssueLoaded) {
          final issues = state.issues;
          final int totalIssues = issues.length;
          final int notSolvedIssues = issues.where((i) => i.solved == false).length;

          return DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: primaryColor,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: primaryColor,
                title: Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Icon(Icons.bug_report_outlined, size: 34, color: ampleOrange),
                      const SizedBox(width: 10),
                      Text(
                        "Issues",
                        style: TextStyle(color: white, fontSize: 30, fontFamily: 'PTSerif'),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5, top: 10),
                        child: Text(
                          "($notSolvedIssues issues to fix)",
                          style: TextStyle(color: white, fontSize: 18, fontFamily: 'PTSerif'),
                        ),
                      ),
                    ],
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(60),
                  child: TabBar(
                    tabs: [
                      Tab(
                        child: Container(
                          width: width(context) * 0.4,
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 7),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: ampleOrange, width: 2),
                          ),
                          child: Row(
                            children: [
                              Text(all, style: TextStyle(color: white)),
                              Container(
                                margin: const EdgeInsets.only(top: 5, left: 5),
                                child: Text("($totalIssues)"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          width: width(context) * 0.42,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: ampleOrange, width: 2),
                          ),
                          child: Row(
                            children: [
                              Text(related, style: TextStyle(color: white)),
                              Container(
                                margin: const EdgeInsets.only(top: 5, left: 5),
                                child: Text("($notSolvedIssues)"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    isScrollable: false,
                    indicator: const BoxDecoration(),
                    labelColor: white,
                    labelPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              body: TabBarView(
                children: [
                  AllList(issues: issues),
                  Notsolveissue(issues: issues.where((i) => !i.solved).toList()),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  final result = await showDialog<bool>(
                    context: context,
                    builder: (context) => CreateIssue(project_Id: widget.project_Id),
                  );

                  if (result == true) {
                    await context.read<IssuesCubit>().fetchIssues(widget.project_Id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Issue added successfully')),
                    );
                  }
                },
                backgroundColor: ampleOrange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: ampleOrange, width: 2),
                ),
                child: const Icon(Icons.add, color: white, size: 30),
              ),

            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
