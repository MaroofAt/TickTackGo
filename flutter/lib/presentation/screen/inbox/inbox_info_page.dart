import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/data/models/inbox/inbox_tasks_model.dart';
import 'package:pr1/presentation/screen/inbox/inbox_bottom_navigation_bar.dart';
import 'package:pr1/presentation/widgets/buttons.dart';
import 'package:pr1/presentation/widgets/text.dart';

class InboxInfoPage extends StatelessWidget {
  final InboxTasksModel inboxTasksModel;

  const InboxInfoPage(this.inboxTasksModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: SizedBox(
          height: height(context) * 0.08,
          child: InboxBottomNavigationBar(
            'Change task Info',
            true,
            inboxTasksModel: inboxTasksModel,
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 10, vertical: height(context) * 0.08),
          height: height(context),
          width: width(context),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.text1(
                  inboxTasksModel.title,
                  textColor: white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                MyText.text1(
                  inboxTasksModel.description,
                  textColor: Colors.white60,
                  fontSize: 18,
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
