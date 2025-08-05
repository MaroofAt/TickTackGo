import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/data/models/projects/fetch_projects_model.dart';
import 'package:pr1/presentation/screen/projects/project_info_app_bar.dart';
import 'package:pr1/presentation/widgets/text.dart';

class ProjectInfoPage extends StatelessWidget {
  final FetchProjectsModel fetchProjectsModel;

  const ProjectInfoPage(this.fetchProjectsModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProjectInfoAppBar.projectInfoAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyText.text1(fetchProjectsModel.title,
                textColor: white, fontSize: 22, fontWeight: FontWeight.bold),
          ],
        ),
      ),
    );
  }
}
