import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/presentation/widgets/app_bar.dart';
import 'package:pr1/presentation/widgets/text.dart';

class ProjectInfoAppBar {
  static AppBar projectInfoAppBar(BuildContext context, Color color) {
    return MyAppBar.appBar(
      context,
      title: MyText.text1('Project Info'),
      foregroundColor: white,
      backgroundColor: color,
    );
  }
}
