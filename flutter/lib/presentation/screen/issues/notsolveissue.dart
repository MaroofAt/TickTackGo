import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/data/models/issues/issue_model.dart';

import '../../../core/constance/colors.dart';
import '../../../core/constance/strings.dart';
import '../../../core/variables/issues_variables.dart';
import 'detalies_issue.dart';


class Notsolveissue extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return   ListView.builder(
      itemCount: unsolvedIssues.length,
      itemBuilder: (context, index) {
        Issue issue=unsolvedIssues[index];
        return Stack(
          children: [
            Card(
              margin: EdgeInsets.symmetric(horizontal:18, vertical: 5),
              color: Colors.grey[800],
              child: ListTile(
                title: Text(issue.title,
                    style: TextStyle(color: white)),
                trailing:issue.isResolved!=true? Icon(Icons.close, color: ampleOrange):Icon(Icons.check,color: ampleOrange),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    issuesdetalies,
                    arguments: issue, // Pass your issue object here
                  );
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
