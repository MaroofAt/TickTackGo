import 'package:flutter/material.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/presentation/widgets/alert_dialog.dart';
import 'package:pr1/presentation/widgets/images.dart';
import 'package:pr1/presentation/widgets/text.dart';

class WorkspacePage extends StatelessWidget {
  final String workspaceName = "Project Alpha";
  final String description =
      "A task management workspace for team collaboration.";
  final String imageUrl =
      "assets/images/logo_images/logo100.png"; // Replace with actual image URL
  final List<String> members = ["Alice", "Bob", "Charlie"];

  WorkspacePage({super.key});

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

            MyText.text1(membersText,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                textColor: Colors.white),
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
                  // showDialog(
                  //   context: context,
                  //   builder: (context) => AlertDialog(
                  //     backgroundColor: Colors.grey[900],
                  //     // Dark theme dialog
                  //     title: MyText.text1(confirmDeletion,
                  //         textColor: Colors.white),
                  //     content: MyText.text1(alertDialogQuestion,
                  //         textColor: Colors.grey[400]),
                  //     actions: [
                  //       TextButton(
                  //           onPressed: () => Navigator.pop(context),
                  //           child: MyText.text1(cancelText,
                  //               textColor: Colors.grey[400])),
                  //       TextButton(
                  //           onPressed: () {},
                  //           child: MyText.text1(deleteText,
                  //               textColor: Colors.red)),
                  //     ],
                  //   ),
                  // );
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
                child: MyText.text1(deleteButtonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
