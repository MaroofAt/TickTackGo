import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/data/models/workspace/get_workspace_model.dart';
import 'package:pr1/presentation/widgets/text.dart';

class BuildMembersList extends StatelessWidget {
  final RetrieveWorkspace retrieveWorkspace;

  const BuildMembersList(this.retrieveWorkspace, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: retrieveWorkspace.members.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return buildOneMemberCard(
              context, retrieveWorkspace.owner!.username, true);
        }
        return buildOneMemberCard(
            context, retrieveWorkspace.members[index - 1].member.username);
      },
    );
  }

  Container buildOneMemberCard(BuildContext context, String name,
      [bool showOwner = false]) {
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
              title: MyText.text1(name, textColor: Colors.white),
            ),
          ),
          showOwner
              ? MyText.text1('Owner', textColor: Colors.white70)
              : Container(),
        ],
      ),
    );
  }
}
