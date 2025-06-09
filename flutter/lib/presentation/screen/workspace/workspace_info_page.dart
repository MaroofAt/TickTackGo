import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/presentation/widgets/alert_dialog.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/images.dart';
import 'package:pr1/presentation/widgets/text.dart';

class WorkspaceInfoPage extends StatelessWidget {
  final String workspaceName = "Project Alpha";
  final String description =
      "A task management workspace for team collaboration.";
  final String imageUrl = "assets/images/logo_images/logo100.png";
  final List<String> members = ["Alice", "Bob", "Charlie"];

  WorkspaceInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Workspace Image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: MyImages.assetImage(imageUrl,
                    height: 150, width: 150, fit: BoxFit.cover),
              ),
            ),
            SizedBox(
                width: width(context),
                child: MyText.text1('workspace image',
                    textColor: white, textAlign: TextAlign.center)),
            const SizedBox(height: 16),

            MyText.text1(
              workspaceName,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              textColor: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: MyText.text1(
                description,
                fontSize: 16,
                textColor: Colors.grey[400],
              ),
            ),

            Divider(color: Colors.grey[700]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText.text1(
                  membersText,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  textColor: Colors.white,
                ),
                MyGestureDetector.gestureDetector(
                  onTap: () {
                    //TODO go to invite people page
                  },
                  child: Container(
                    height: width(context) * 0.1,
                    width: width(context) * 0.3,
                    decoration: BoxDecoration(
                      color: Theme.of(context).secondaryHeaderColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: MyText.text1(
                        'Invite',
                        textColor: Theme.of(context).scaffoldBackgroundColor,
                        fontSize: 20,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey[900], // Dark card background
                    elevation: 3,
                    child: ListTile(
                      leading: const Icon(Icons.person, color: Colors.white),
                      title: Text(members[index],
                          style: const TextStyle(color: Colors.white)),
                    ),
                  );
                },
              ),
            ),

            // Delete Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  MyAlertDialog.showAlertDialog(
                    context,
                    content: alertDialogQuestion,
                    firstButtonText: deleteText,
                    firstButtonAction: () {
                      //TODO delete workspace request
                    },
                    secondButtonText: cancelText,
                    secondButtonAction: () {
                      popScreen(context);
                    },
                  );
                },
                child: MyText.text1(deleteButtonText, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
