import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pr1/business_logic/workspace_cubit/workspace_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/data/models/workspace/sent_invites_model.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';
import 'package:pr1/presentation/widgets/text.dart';

class SentInvitesListItem extends StatelessWidget {
  final SentInvitesModel sentInvitesModel;

  int selectedInvite = 0;

  SentInvitesListItem(this.sentInvitesModel, {super.key});

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
          MyText.text1(
              "Sent At: ${DateFormat('dd-M-yyyy').format(sentInvitesModel.createdAt!)}",
              textColor: const Color(0xFFB0B0B0),
              fontSize: 16),
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
      trailing: BlocProvider(
        create: (context) => WorkspaceCubit(),
        child: buildCancelClick(context),
      ),
    );
  }

  Widget buildCancelClick(BuildContext context) {
    return MyGestureDetector.gestureDetector(
      onTap: () {
        if (sentInvitesModel.status == 'pending') {
          selectedInvite = sentInvitesModel.id;
          BlocProvider.of<WorkspaceCubit>(context).cancelInvites(
              sentInvitesModel.workspace!.id, sentInvitesModel.id);
        }
      },
      child: BlocConsumer<WorkspaceCubit, WorkspaceState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is InviteCancelingState &&
              selectedInvite == sentInvitesModel.id) {
            return Center(
              child: LoadingIndicator.circularProgressIndicator(),
            );
          }
          return MyText.text1(
            'Cancel?',
            textColor: sentInvitesModel.status != 'pending'
                ? lightGrey
                : Theme.of(context).secondaryHeaderColor,
            fontSize: 18,
          );
        },
      ),
    );
  }
}
