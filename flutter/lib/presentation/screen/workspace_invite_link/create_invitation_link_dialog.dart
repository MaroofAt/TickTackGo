import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/text.dart';

class CreateInvitationLinkDialog extends StatefulWidget {
  const CreateInvitationLinkDialog({super.key});

  @override
  State<CreateInvitationLinkDialog> createState() =>
      _CreateInvitationLinkDialogState();
}

class _CreateInvitationLinkDialogState
    extends State<CreateInvitationLinkDialog> {

  String inviteLink = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: SizedBox(
        height: height(context) * 0.2,
        width: width(context) * 0.5,
        child: MyText.text1('Create Invitation Link Here', textColor: white),
      ),
      content: SizedBox(
        height: height(context),
        width: width(context),
        child: Row(
          children: [
            buildLinkText(context),
            buildCopyButton(context, inviteLink),
          ],
        ),
      ),
    );
  }

  Widget buildLinkText(BuildContext context) {
    return Container(
      width: width(context) * 0.65,
      height: height(context) * 0.2,
      color: Colors.blueGrey,
      child: MyText.text1('generate invite link', textColor: lightGrey),
    );
  }

  Widget buildCopyButton(BuildContext context, String inviteLink) {
    return MyGestureDetector.gestureDetector(
      onTap: (){
        if(inviteLink.isNotEmpty) {
          Clipboard.setData(ClipboardData(text: inviteLink));
        }
      },
      child: Container(
        height: height(context) * 0.2,
        width: width(context) * 0.2,
        color: Colors.black,
        child: Center(
          child: MyIcons.icon(Icons.copy, color: white),
        ),
      ),
    );
  }
}

/*
*
* to copy onPressed: ,
* */
