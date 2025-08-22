import 'package:flutter/material.dart';
import 'package:pr1/data/models/workspace/sent_invites_model.dart';
import 'package:pr1/presentation/screen/workspace/sent_invites_list_item.dart';

class ShowInvitesList extends StatelessWidget {
  final List<SentInvitesModel> sentInvites;
  const ShowInvitesList(this.sentInvites, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sentInvites.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.grey[900],
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: SentInvitesListItem(sentInvites[index]),
        );
      },
    );
  }
}

