import 'package:flutter/material.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/data/models/projects/retrieve_project_model.dart';
import 'package:pr1/data/models/workspace/get_workspace_model.dart';
import 'package:pr1/presentation/widgets/text.dart';

class BuildMembersList extends StatelessWidget {
  final RetrieveProjectModel retrieveProjectModel;

  const BuildMembersList(this.retrieveProjectModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: retrieveProjectModel.members.length,
      itemBuilder: (context, index) {
        return buildOneMemberCard(
            context, index);
      },
    );
  }

  Container buildOneMemberCard(BuildContext context,int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: width(context) * 0.6,
            child: ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: MyText.text1(retrieveProjectModel.members[index].member.username, textColor: Colors.white),
            ),
          ),
           MyText.text1(retrieveProjectModel.members[index].role, textColor: Colors.white70)

        ],
      ),
    );
  }
}
