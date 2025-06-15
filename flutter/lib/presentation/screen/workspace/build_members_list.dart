import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/data/models/workspace/get_workspace_model.dart';
import 'package:pr1/presentation/widgets/text.dart';

class BuildMembersList extends StatelessWidget {
  final RetrieveWorkspace retrieveWorkspace;

  const BuildMembersList(this.retrieveWorkspace, {super.key});

  @override
  Widget build(BuildContext context) {
    return retrieveWorkspace.members.isEmpty
        ? Center(
            child: MyText.text1(
              'No members here',
              textColor: white,
              fontSize: 20,
            ),
          )
        : ListView.builder(
            itemCount: retrieveWorkspace.members.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.grey[900],
                elevation: 3,
                child: ListTile(
                  leading: const Icon(Icons.person, color: Colors.white),
                  title: Text(retrieveWorkspace.members[index].member.username,
                      style: const TextStyle(color: Colors.white)),
                ),
              );
            },
          );
  }
}
