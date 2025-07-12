import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/inbox_cubit/inbox_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/data/models/inbox/inbox_tasks_model.dart';
import 'package:pr1/presentation/screen/inbox/inbox_info_page.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/text.dart';

class InboxTasksList extends StatelessWidget {
  final List<InboxTasksModel> inboxTasksList;

  const InboxTasksList(this.inboxTasksList, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: inboxTasksList.length,
      itemBuilder: (context, index) {
        return MyGestureDetector.gestureDetector(
          onTap: () {
            pushScreen(
              context,
              InboxInfoPage(inboxTasksList[index]),
            );
          },
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: height(context) * 0.13,
            decoration: BoxDecoration(
              color:
                  Theme.of(context).scaffoldBackgroundColor.withAlpha(225),
              borderRadius: BorderRadius.circular(24),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: lightGrey.withAlpha(50),
                  spreadRadius: 5,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.text1(
                  inboxTasksList[index].title,
                  textColor: white,
                  fontSize: 22,
                ),
                MyText.text1(
                  'priority: ${inboxTasksList[index].priority}',
                  textColor: white,
                  fontSize: 18,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
