import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';

class All_Issues extends StatefulWidget {
  const All_Issues({super.key});

  @override
  State<All_Issues> createState() => _All_IssuesState();
}

class _All_IssuesState extends State<All_Issues> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(backgroundColor: primaryColor,title: Container(
        margin: EdgeInsets.only(top:20),
        child: Row(
          children: [
            Icon(Icons.bug_report_outlined,size: 30, color: greatMagenda,),
            SizedBox(width: 10,),
            Text("Issues",style: TextStyle(color: white,fontSize: 28,fontFamily: 'PTSerif'),) ,
          ],
        ),
      ),),
    );
  }
}
