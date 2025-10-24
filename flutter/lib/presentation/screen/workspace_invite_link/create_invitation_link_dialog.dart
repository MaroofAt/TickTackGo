import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/invite_link_cubit/invite_link_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_service.dart';
import 'package:pr1/core/functions/show_snack_bar.dart';
import 'package:pr1/presentation/widgets/alert_dialog.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/text.dart';

class CreateInvitationLinkDialog extends StatefulWidget {
  final int workspaceId;

  const CreateInvitationLinkDialog({required this.workspaceId, super.key});

  @override
  State<CreateInvitationLinkDialog> createState() =>
      _CreateInvitationLinkDialogState();
}

class _CreateInvitationLinkDialogState
    extends State<CreateInvitationLinkDialog> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<InviteLinkCubit>(context)
        .createInviteLink(widget.workspaceId);
  }

  String inviteLink = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: SizedBox(
        height: height(context) * 0.08,
        width: width(context) * 0.1,
        child: MyText.text1('Create Invitation Link Here', textColor: white),
      ),
      content: SizedBox(
        height: height(context) * 0.08,
        width: width(context) * 0.8,
        child: BlocConsumer<InviteLinkCubit, InviteLinkState>(
          listener: (context, state) {
            if (state is InviteLinkCreatingFailedState) {
              failingDialog(state.errorMessage);
            }
            if (state is GettingInviteLinkFailedState) {
              failingDialog(state.errorMessage);
            }
          },
          builder: (context, state) {
            if (state is InviteLinkCreatingSucceededState) {
              inviteLink = state.createInviteLinkModel.link;
              return Row(
                children: [
                  buildLinkText(context),
                  buildCopyButton(context),
                ],
              );
            } else if (state is GettingInviteLinkSucceededState) {
              inviteLink = state.getInviteLinkModel.link;
              return Row(
                children: [
                  buildLinkText(context),
                  buildCopyButton(context),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget buildLinkText(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: height(context) * 0.015),
      width: width(context) * 0.5,
      height: height(context) * 0.06,
      color: Colors.black,
      child: MyText.text1(
        inviteLink,
        textColor: lightGrey,
        fontSize: 18,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget buildCopyButton(BuildContext context) {
    return MyGestureDetector.gestureDetector(
      onTap: () {
        if (inviteLink.isNotEmpty) {
          Clipboard.setData(ClipboardData(text: inviteLink));
          showSnackBar(
            context,
            'link copied successfully',
            backgroundColor: Colors.green,
            textColor: white,
            seconds: 1,
            milliseconds: 500,
          );
          NavigationService().popScreen(context);
        }
      },
      child: Container(
        height: height(context) * 0.06,
        width: height(context) * 0.06,
        color: Colors.blueGrey,
        child: Center(
          child: MyIcons.icon(Icons.copy, color: white),
        ),
      ),
    );
  }

  void failingDialog(String errorMessage) {
    NavigationService().popScreen(context);
    MyAlertDialog.showAlertDialog(
      context,
      content: errorMessage,
      firstButtonText: okText,
      firstButtonAction: () {
        NavigationService().popScreen(context);
      },
      secondButtonText: '',
      secondButtonAction: () {},
    );
  }
}
