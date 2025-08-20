import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/comment_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/data/models/issues/issue_model.dart';

import '../../../core/variables/issues_variables.dart';
import '../../../data/models/comments/comment.dart';
import '../../widgets/creatTextFiled.dart';
import 'all_list.dart';

class Detalies_Issue extends StatefulWidget {
  final Issue issue;
  const Detalies_Issue({super.key, required this.issue});

  @override
  State<Detalies_Issue> createState() => _Detalies_IssueState();
}

class _Detalies_IssueState extends State<Detalies_Issue> {
  final TextEditingController commentcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(backgroundColor: primaryColor,
        title: Row(
          children: [
            Expanded(
              child: Text(
                widget.issue.title,
                style: TextStyle(color: white, fontSize: 24, fontFamily: 'PTSerif'),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            const Spacer(),
            Icon(Icons.list, color: ampleOrange),
          ],
        )
        ,leading: IconButton(onPressed: (){
       popScreen(context);
      }
          , icon:SizedBox(width: 10,child: Icon(Icons.arrow_back_sharp,color: ampleOrange,size: 24,))),),
      body:BlocBuilder<CommentCubit, CommentState>(
  builder: (context, comments) {
    return Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: 20,),
              Expanded(
                child: ListTile(
                  title: Text(
                    widget.issue.description,
                    style: TextStyle(color: white, fontSize: 20, fontFamily: 'PTSerif'),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle:  Text(
                    "Related with ${widget.issue.projectId} ",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left:10),
                padding: EdgeInsets.all(10),
                width: width(context)*0.2,
                height: height(context)*0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all( Radius.circular(40)),
          color: ampleOrange
                ),
                child: widget.issue.isResolved==true? Icon(Icons.check,color: white,size:30,): Icon(Icons.close,color: white,size:30,),
              ),
SizedBox(width:10)
            ],
          ),
          Container(child:  CreateTextField(
            iconsuf:IconButton(onPressed: (){
    if (commentcontroller.text.isNotEmpty) {
    setState(() {
      context.read<CommentCubit>().addComment(2, commentcontroller.text);
    // widget.issue.comments.add(Comment(
    // id: DateTime.now().millisecondsSinceEpoch.toString(),
    // content: commentcontroller.text,
    // authorName: "Current User", // Replace with actual user
    // createdAt: DateTime.now(),
    // ));
    // commentcontroller.clear();
      
    });
    }
    },icon:Icon(Icons.send,color:parrotGreen,)),
          fillcolor: ampleOrange.withOpacity(0.2),
            text: "Your Comment",
            icon: Icon(Icons.comment,color: parrotGreen,),
            controller: commentcontroller,
          ),margin: EdgeInsets.only(left: 15,top: 10,bottom: 10),),

          Expanded(
            child: ListView.builder(
              itemCount: widget.issue.comments.length,
              itemBuilder: (context, index) {
                final comment = widget.issue.comments[index];
                return Stack(
                  children: [
                    Card(
                      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                      color: Colors.grey[800],
                      child: ListTile(
                        title: Text(
                          comment.body,
                          style: TextStyle(color: white),
                        ),
                        subtitle: Text(
                          "By ${comment.user.username} • ${comment.createdAt.toString().split(' ')[0]}",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 20,
                      child: Container(
                        width: 20,
                        height: 40,
                        decoration: BoxDecoration(
                          color: ampleOrange,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(400),
                            topLeft: Radius.circular(400),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

        ],
      );
  },
)
    );
  }
}
