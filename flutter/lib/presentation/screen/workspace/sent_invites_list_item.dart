import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/data/models/workspace/sent_invites_model.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/text.dart';

class SentInvitesListItem extends StatelessWidget {
  final SentInvitesModel sentInvitesModel;

  const SentInvitesListItem(this.sentInvitesModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        child: MyIcons.icon(Icons.send, color: Colors.black),
      ),
      title: MyText.text1("To: ${sentInvitesModel.receiver!.username}",
          textColor: Colors.white),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.text1("Workspace: ${sentInvitesModel.workspace!.title}",
              textColor: const Color(0xFFB0B0B0)),
          MyText.text1("Sent by: ${sentInvitesModel.sender!.username}",
              textColor: const Color(0xFFB0B0B0), fontSize: 16),
          MyText.text1("Sent At: ${DateFormat('dd-M-yyyy').format(sentInvitesModel.createdAt!)}",
              textColor: const Color(0xFFB0B0B0), fontSize: 16),
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).secondaryHeaderColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: MyText.text1(sentInvitesModel.status,
                textColor: Colors.black, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
