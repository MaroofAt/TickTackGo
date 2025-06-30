import 'package:flutter/material.dart';
import 'package:pr1/data/models/workspace/get_workspace_model.dart';
import 'package:pr1/presentation/widgets/images.dart';
import 'package:pr1/presentation/widgets/text.dart';

class WorkspaceInfoHeader extends StatelessWidget {

  final String imageUrl = "assets/images/logo_images/logo100.png";
  final RetrieveWorkspace retrieveWorkspace;

  const WorkspaceInfoHeader(this.retrieveWorkspace,{super.key});

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
                : MyImages.networkImage(retrieveWorkspace.image),
          ),
        ),
        const SizedBox(height: 16),
        MyText.text1(
          retrieveWorkspace.title,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          textColor: Colors.white,
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
