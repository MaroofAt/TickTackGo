import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/data/models/issues/list_issues_model.dart';

import '../../../business_logic/issues/issues_cubit.dart';
import '../../../core/constance/colors.dart';
import '../../../core/constance/strings.dart';


class NotSolvedIssue extends StatelessWidget {
 final List<ListIssuesModel> issues;
 const NotSolvedIssue({super.key, required this.issues});
  @override
  Widget build(BuildContext context) {
    return   ListView.builder(
      itemCount: issues.length,
      itemBuilder: (context, index) {
        var issue=issues[index];
        return Stack(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(horizontal:18, vertical: 5),
              color: Colors.grey[800],
              child: ListTile(
                title: Text(issue.title,
                    style: const TextStyle(color: white)),
                trailing:issue.solved!=true? const Icon(Icons.close, color: ampleOrange):const Icon(Icons.check,color: ampleOrange),
                onTap: () async {
                  final value = await Navigator.pushNamed(
                    context,
                    issuesDetails,
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
            Positioned(left:10,top:12, child: Container(width: 20,height: 40,decoration: const BoxDecoration(
              color: ampleOrange,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(400),topLeft: Radius.circular(400)),
            ),)),
          ],
        );
      },
    );
  }
}
