import 'package:flutter/material.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/data/models/workspace/get_workspace_model.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/images.dart';
import 'package:pr1/presentation/widgets/text.dart';

class WorkspaceInfoHeader extends StatelessWidget {
  final String imageUrl = "assets/images/logo_images/logo100.png";
  final RetrieveWorkspaceModel retrieveWorkspace;

  const WorkspaceInfoHeader(this.retrieveWorkspace, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: retrieveWorkspace.image == null
                ? MyImages.assetImage(imageUrl,
                    height: 150, width: 150, fit: BoxFit.cover)
                : MyImages.networkImage(
                    retrieveWorkspace.image,
                    width: width(context) * 0.6,
                    height: width(context) * 0.6,
                  ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText.text1(
              retrieveWorkspace.title,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              textColor: Colors.white,
            ),
            MyGestureDetector.gestureDetector(
              onTap: () {
                pushNamed(
                  context,
                  createUpdateWorkspacePageName,
                  args: {
                    'title': retrieveWorkspace.title,
                    'description': retrieveWorkspace.description,
                    'image': retrieveWorkspace.image,
                    'retrieveWorkspaceModel': retrieveWorkspace,
                  },
                );
              },
              child: MyIcons.icon(Icons.edit, color: Colors.grey),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: MyText.text1(
            retrieveWorkspace.description,
            fontSize: 16,
            textColor: Colors.grey[400],
          ),
        ),
      ],
    );
  }
}
