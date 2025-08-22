import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/workspace_cubit/workspace_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/data/models/workspace/sent_invites_model.dart';
import 'package:pr1/presentation/screen/workspace/show_invites_list.dart';
import 'package:pr1/presentation/widgets/app_bar.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';
import 'package:pr1/presentation/widgets/text.dart';

class SentInvitesPage extends StatefulWidget {
  final int workspaceId;
  final String workspaceTitle;

  const SentInvitesPage(this.workspaceId, this.workspaceTitle, {super.key});

  @override
  State<SentInvitesPage> createState() => _SentInvitesPageState();
}

class _SentInvitesPageState extends State<SentInvitesPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<WorkspaceCubit>(context).sentInvites(widget.workspaceId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar.appBar(
          context,
          title: MyText.text1('Invites Details'),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          foregroundColor: white,
        ),
        body: BlocBuilder<WorkspaceCubit, WorkspaceState>(
          builder: (context, state) {
            if (state is SentInvitesRetrievingSucceededState) {
              return buildSentInvitesPage(context, state.sentInvitesModel);
            }
            return Center(
              child: LoadingIndicator.circularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget buildSentInvitesPage(
      BuildContext context, List<SentInvitesModel> sentInvites) {
    return SizedBox(
      height: height(context),
      width: width(context),
      child: sentInvites.isEmpty
          ? Center(
              child: MyText.text1(
                'no sent invites in this workspace',
                textColor: white,
                fontSize: 22,
              ),
            )
          : buildSentInvitesList(sentInvites),
    );
  }

  Expanded buildSentInvitesList(List<SentInvitesModel> sentInvites) {
    return Expanded(
      child: ShowInvitesList(sentInvites),
    );
  }
}
