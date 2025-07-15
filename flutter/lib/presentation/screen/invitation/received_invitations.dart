import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/invitation_cubit/invitation_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/presentation/screen/invitation/invites_list.dart';
import 'package:pr1/presentation/widgets/alert_dialog.dart';
import 'package:pr1/presentation/widgets/app_bar.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';
import 'package:pr1/presentation/widgets/text.dart';

class ReceivedInvitations extends StatefulWidget {
  const ReceivedInvitations({super.key});

  @override
  State<ReceivedInvitations> createState() => _ReceivedInvitationsState();
}

class _ReceivedInvitationsState extends State<ReceivedInvitations> {
  @override
  void initState() {
    super.initState();
    getInvites();
  }

  getInvites() async {
    BlocProvider.of<InvitationCubit>(context).fetchUserInvites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.appBar(
        context,
        title: MyText.text1('Received Invitations'),
        foregroundColor: white,
        backgroundColor: transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
        child: BlocConsumer<InvitationCubit, InvitationState>(
          listener: (context, state) {
            if (state is GetInvitesFailedState) {
              MyAlertDialog.showAlertDialog(
                context,
                content: state.errorMessage,
                firstButtonText: 'go back',
                firstButtonAction: () {
                  popScreen(context);
                  popScreen(context);
                },
                secondButtonText: '',
                secondButtonAction: () {},
              );
            }
          },
          builder: (context, state) {
            if (state is GetInvitesSucceededState) {
              if (state.userInvitesList.isEmpty) {
                return Center(
                  child: MyText.text1('No Received Invites',
                      textColor: white, fontSize: 20),
                );
              } else {
                return InvitesList(state.userInvitesList);
              }
            }
            return Center(
              child: LoadingIndicator.circularProgressIndicator(
                  color: Theme.of(context).secondaryHeaderColor),
            );
          },
        ),
      ),
    );
  }
}
