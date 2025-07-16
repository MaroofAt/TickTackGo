import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/variables/issues_variables.dart';

import '../../../data/models/issues/issue_model.dart';
import 'all_list.dart';
import 'creat_issue.dart';
import 'notsolveissue.dart';

class All_Issues extends StatefulWidget {
  const All_Issues({super.key});

  @override
  State<All_Issues> createState() => _All_IssuesState();
}

class _All_IssuesState extends State<All_Issues> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading:false,backgroundColor: primaryColor, title: Container(
        margin: EdgeInsets.only(top: 20),
        child: Row(
          children: [
            Icon(Icons.bug_report_outlined, size: 34, color: ampleOrange,),
            SizedBox(width: 10,),
            Text("Issues", style: TextStyle(
                color: white, fontSize: 30, fontFamily: 'PTSerif'),),
            Container(margin: EdgeInsets.only(left: 5, top: 10),
                child: Text("("+number_of_issues_notsolved+ " issues to fix)", style: TextStyle(
                    color: white, fontSize: 18, fontFamily: 'PTSerif'),)),

          ],
        ),
      ),
      bottom:PreferredSize(
    preferredSize: Size.fromHeight(60),
    child: TabBar(
        tabs: [
          Tab(
            child: Container(
              width:  width(context)*0.4,
              padding: EdgeInsets.symmetric(horizontal:50, vertical: 7),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: ampleOrange,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    all,
                    style: TextStyle(color: white),
                  ),
                  Container(margin: EdgeInsets.only(top: 5,left: 5),child: Text("("+number_of_all_solvedornot+")"),)
                ],
              ),
            ),
          ),
          Tab(
            child: Container(
              width: width(context)*0.42,
              padding: EdgeInsets.symmetric(horizontal:30  , vertical: 7),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: ampleOrange,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    related,
                    style: TextStyle(color: white),
                  ),
                  Container(margin: EdgeInsets.only(top: 5,left: 5),child: Text("("+number_of_related+")"),)
                ],
              ),
            ),
          ),
        ],
        isScrollable: false,
        indicator: BoxDecoration(),
        labelColor: white,
        // unselectedLabelColor: ampleOrange,
        labelPadding: EdgeInsets.zero,
      ),),

      ),
      body:TabBarView(children: [
        AllList(),
        Notsolveissue(),
      ]) ,floatingActionButton: FloatingActionButton(
      onPressed: () async {
    final newIssue = await showDialog<Issue>(
    context: context,
    builder: (context) => CreateIssue(),
    );

    if (newIssue != null) {
    setState(() {
    sampleIssues.add(newIssue);
    });
    }
    },

      backgroundColor: ampleOrange,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: BorderSide(color: ampleOrange, width: 2),
      ),
      child: const Icon(Icons.add, color: white, size: 30),
    ),
    ));
  }

}