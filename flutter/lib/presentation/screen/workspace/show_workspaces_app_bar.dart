import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/presentation/widgets/app_bar.dart';
import 'package:pr1/presentation/widgets/text.dart';

class ShowWorkspacesAppBar {
  static AppBar workspacesAppBar(BuildContext context) {
    return MyAppBar.appBar(
      context,
      title: MyText.text1('Workspaces'),
      foregroundColor: white,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}