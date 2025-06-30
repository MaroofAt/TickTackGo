import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/data/models/projects/fetch_projects_model.dart';
import 'package:pr1/presentation/widgets/text.dart';

class BuildProjectsList extends StatelessWidget {
  final List<FetchProjectsModel> projects;

  const BuildProjectsList(this.projects, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        String hex = projects[index].color.replaceFirst('#', '');
        if (hex.length == 6) hex = 'ff$hex'; // Adds opacity if not provided
        Color color = Color(int.parse(hex, radix: 16));
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
}
