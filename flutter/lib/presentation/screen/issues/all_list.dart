import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/data/models/issues/issue_model.dart';
import 'package:pr1/data/models/issues/list_issues_model.dart';

import '../../../business_logic/issues/issues_cubit.dart';
import '../../../core/constance/colors.dart';
import '../../../core/constance/strings.dart';
import '../../../core/variables/issues_variables.dart';
import 'detalies_issue.dart';


class AllList extends StatelessWidget {
  final List<ListIssuesModel> issues;
  const AllList({super.key, required this.issues});

  @override
  Widget build(BuildContext context) {
    return   ListView.builder(
      itemCount: issues.length,
      itemBuilder: (context, index) {
        var issue=issues[index];
        return Stack(
        children: [
          Card(
            margin: EdgeInsets.symmetric(horizontal:18, vertical: 5),
            color: Colors.grey[800],
            child: ListTile(
              title: Text(issue.title,
                  style: TextStyle(color: white)),
              trailing:issue.solved!=true? Icon(Icons.close, color: ampleOrange):Icon(Icons.check,color: ampleOrange),
              onTap: () async {
                final value = await Navigator.pushNamed(
                  context,
                  issuesdetalies,
                  arguments: {
                    "issueId": issue.id,
                    "projectId": issue.project.id,
                  },
                );

                if (value == true) {
                  context.read<IssuesCubit>().fetchIssues(issue.project.id);
                }
              },

            ),

          ),
          Positioned(child: Container(width: 20,height: 40,decoration: BoxDecoration(
        color: ampleOrange,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(400),topLeft: Radius.circular(400)),
        ),),left:10,top:12),
        ],
        );
      },
    );
  }
}
