import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/data/models/projects/fetch_projects_model.dart';
import 'package:pr1/data/models/workspace/fetch_workspaces_model.dart';
import 'package:pr1/presentation/screen/projects/build_projects_list.dart';
import 'package:pr1/presentation/widgets/text.dart';

class BuildProjectListItem extends StatelessWidget {
  final Project projectsModel;
  final Color color;
  final double containerWidth;
  final double marginFromLeft;
  final int workspaceId;

  const BuildProjectListItem(this.projectsModel, this.color,
      this.containerWidth, this.marginFromLeft, this.workspaceId,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: containerWidth,
            height: height(context) * 0.08,
            margin: EdgeInsets.only(left: marginFromLeft, bottom: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius:
                  const BorderRadius.horizontal(right: Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: color.withAlpha(50),
                  offset: const Offset(2, 2),
                  blurRadius: 2,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: height(context),
                  width: width(context) * 0.05,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(16)),
                  ),
                ),
                MyText.text1(projectsModel.title, textColor: white),
              ],
            ),
          ),
          projectsModel.subProjects.isNotEmpty
              ? BuildProjectsList(
                  projectsModel.subProjects,
                  workspaceId,
                  newWidth: containerWidth * 0.9,
                  newMargin: marginFromLeft * 1.2,
                )
              : Container(),
        ],
      ),
    );
  }
}
