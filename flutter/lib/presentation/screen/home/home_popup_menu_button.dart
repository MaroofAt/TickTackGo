import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/data/models/workspace/get_workspaces_model.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/text.dart';

class HomePopupMenuButton extends StatelessWidget {
  List<dynamic> workspaces;

  HomePopupMenuButton(this.workspaces, {super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<FetchWorkspacesModel>(
      icon: MyIcons.icon(Icons.more_vert),
      onSelected: (value) {},
      itemBuilder: (context) {
        return List.generate(
          workspaces.length,
          (index) {
            return PopupMenuItem(
              child: MyText.text1(workspaces[index].title),
            );
          },
        );
      },
    );
  }
}
