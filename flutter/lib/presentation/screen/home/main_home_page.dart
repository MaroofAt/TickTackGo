import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/presentation/screen/home/card_builder.dart';
import 'package:pr1/presentation/screen/home/task_card.dart';
import 'package:pr1/presentation/widgets/animated_dropdown.dart';
import 'package:pr1/presentation/widgets/circle.dart';
import 'package:pr1/presentation/widgets/dropdown_button2.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/text.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    // backgroundImage: AssetImage(''),
                    radius: width(context) * 0.1,
                    child:
                        MyIcons.icon(Icons.person, size: width(context) * 0.1),
                  ),
                  MyGestureDetector.gestureDetector(
                    onTap: () {
                      pushNamed(context, receivedInvitationPageRoute);
                    },
                    child: MyCircle.circle(
                      width(context) * 0.18,
                      color: transparent,
                      child: Center(
                        child: MyIcons.icon(
                          Icons.notifications,
                          color: white,
                          size: width(context) * 0.1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              MyText.text1(
                '$hiText,\nUser Name',
                textColor: Colors.white,
                fontSize: 24,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  CardBuilder(
                    color: sleekCyan,
                    label: workspaceText,
                    content: 'current Workspace',
                    icon: Icons.work,
                    onTap: () {
                      pushNamed(context, workspacesShowPageRoute);
                    },
                  ),
                  CardBuilder(
                    color: greatMagenda,
                    label: projectText,
                    content: '5 $projectText',
                    icon: Icons.auto_awesome,
                    onTap: () {},
                  ),
                ],
              ),
              Row(
                children: [
                  CardBuilder(
                    color: parrotGreen,
                    label: inboxText,
                    content: '17 $tasksText',
                    icon: Icons.folder_copy,
                    onTap: () {},
                  ),
                  // CardBuilder(
                  //   color: ampleOrange,
                  //   label: 'Cancel',
                  //   taskCount: '02 tasks',
                  //   icon: Icons.cancel,
                  //
                  //   onTap: () {},
                  // ),
                ],
              ),
              const SizedBox(height: 16),
              MyText.text1(
                allTasksText,
                textColor: Colors.white,
                fontSize: 18,
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ListView(
                  children: const [
                    TaskCard(),
                    TaskCard(),
                    TaskCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
