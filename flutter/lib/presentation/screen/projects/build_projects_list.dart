import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/projects_cubit/projects_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/data/models/projects/fetch_projects_model.dart';
import 'package:pr1/presentation/screen/projects/create_project.dart';
import 'package:pr1/presentation/widgets/buttons.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';
import 'package:pr1/presentation/widgets/text.dart';

class BuildProjectsList extends StatelessWidget {
  final int workspaceId;
  final List<FetchProjectsModel> projects;

  const BuildProjectsList(this.projects, this.workspaceId, {super.key});

  void _showAddProjectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => ProjectsCubit(),
        child: CreateProjectDialog(workspaceId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: projects.length + 1,
      itemBuilder: (context, index) {
        Color color = transparent;
        if (index == projects.length) {
          return buildAddProjectButton(context);
        } else {
          String hex = projects[index].color.replaceFirst('#', '');
          if (hex.length == 6) hex = 'ff$hex'; // Adds opacity if not provided
          color = Color(int.parse(hex, radix: 16));
        }
        return Container(
          width: width(context) * 0.6,
          height: height(context) * 0.08,
          margin: EdgeInsets.only(left: width(context) * 0.2, bottom: 20),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border.all(color: color, width: 1.5),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: color.withAlpha(50),
                offset: const Offset(8, 8),
                blurRadius: 5,
                spreadRadius: 5,
              )
            ],
          ),
          child: Row(
            children: [
              MyText.text1(projects[index].title, textColor: white),
            ],
          ),
        );
      },
    );
  }

  Widget buildAddProjectButton(BuildContext context) {
    return Container(
      height: height(context) * 0.06,
      margin: EdgeInsets.only(left: width(context) * 0.2, bottom: 20),
      child: MyButtons.primaryButton(
        () {
          _showAddProjectDialog(context);
        },
        Theme.of(context).secondaryHeaderColor,
        child: Center(
          child: MyText.text1('Add new project?', fontSize: 18),
        ),
      ),
    );
  }
}
