import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/projects_cubit/projects_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/functions/user_functions.dart';
import 'package:pr1/data/models/projects/retrieve_project_model.dart';
import 'package:pr1/presentation/widgets/buttons.dart';
import 'package:pr1/presentation/widgets/circle.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/images.dart';
import 'package:pr1/presentation/widgets/text.dart';
import 'package:pr1/presentation/widgets/word_switch.dart';

class ShowMemberInfoDialog extends StatefulWidget {
  final MemberElement memberElement;
  final int projectId;
  final int ownerId;

  const ShowMemberInfoDialog(this.memberElement, this.projectId, this.ownerId,
      {super.key});

  @override
  State<ShowMemberInfoDialog> createState() => _ShowMemberInfoDialogState();
}

class _ShowMemberInfoDialogState extends State<ShowMemberInfoDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      content: SizedBox(
        height: height(context) * 0.2,
        width: width(context) * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //TODO show user Image
            // Container(
            //   height: height(context) * 0.3,
            //   width: width(context) * 0.3,
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     image: MyImages.decorationImage(isAssetImage: false, image: memberElement.member.image),
            //   ),
            // ),
            MyText.text1('Name: ${widget.memberElement.member.username}',
                textColor: white, fontSize: 18),
            MyText.text1('Email: ${widget.memberElement.member.email}',
                textColor: white, fontSize: 18),
            Row(
              children: [
                MyText.text1('Role: ', textColor: white, fontSize: 18),
                WordSwitch(
                  firstOption: 'editor',
                  secondOption: 'viewer',
                  selectedValue: widget.memberElement.role,
                  height: height(context) * 0.04,
                  onChanged: (String value) {
                    if (isAdmin(widget.ownerId)) {
                      BlocProvider.of<ProjectsCubit>(context).changeUserRole(
                        widget.memberElement.member.id,
                        widget.projectId,
                        value,
                      );
                      setState(() {
                        widget.memberElement.role = value;
                      });
                    }
                  },
                  selectedColor: Theme.of(context).primaryColor,
                  selectedTextColor: black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
