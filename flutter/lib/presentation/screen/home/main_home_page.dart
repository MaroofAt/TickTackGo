import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/presentation/screen/home/card_builder.dart';
import 'package:pr1/presentation/screen/home/task_card.dart';
import 'package:pr1/presentation/widgets/animated_dropdown.dart';
import 'package:pr1/presentation/widgets/dropdown_button2.dart';
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
              const CircleAvatar(
                // backgroundImage: AssetImage(''),
                radius: 30,
              ),
              const SizedBox(height: 16),
              MyText.text1(
                'Hi,\nUser Name',
                textColor: Colors.white,
                fontSize: 24,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  CardBuilder(
                    color: sleekCyan,
                    label: 'Workspaces',
                    content: 'current Workspace',
                    icon: Icons.work,
                    onTap: () {},
                  ),
                  CardBuilder(
                    color: greatMagenda,
                    label: 'Projects',
                    content: '5 projects',
                    icon: Icons.auto_awesome,
                    onTap: () {},
                  ),
                ],
              ),
              Row(
                children: [
                  CardBuilder(
                    color: parrotGreen,
                    label: 'Inbox',
                    content: '17 tasks',
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
                'All Tasks',
                textColor: Colors.white,
                fontSize: 18,
              ),
              SizedBox(height: 15),
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
