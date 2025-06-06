import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/presentation/widgets/app_bar.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/images.dart';
import 'package:pr1/presentation/widgets/text.dart';

class WorkspacesShowPage extends StatelessWidget {
  const WorkspacesShowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.appBar(context,
          title: MyText.text1('Workspaces'), foregroundColor: white),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pushNamed(context, workspaceCreatePageRoute);
        },
        child: MyIcons.icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        height: height(context),
        width: width(context),
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return MyGestureDetector.gestureDetector(
              onTap: () {
                if (index == 1) {
                  pushNamed(context, workspaceInfoRoute);
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: height(context) * 0.1,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 10,
                      children: [
                        Container(
                          height: height(context) * 0.1,
                          width: height(context) * 0.1,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: MyImages.decorationImage(
                                isAssetImage: true,
                                image:
                                    'assets/images/workspace_images/img.png'),
                          ),
                        ),
                        MyText.text1('workspace name', fontSize: 18),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MyText.text1(index == 1 ? 'current workspace' : ''),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
