import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/presentation/widgets/app_bar.dart';
import 'package:pr1/presentation/widgets/text.dart';

class CreateTaskAppBar {
  static AppBar createTaskAppBar(BuildContext context) {
    return MyAppBar.appBar(
        context,
        title: MyText.text1('Add new Task'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: white,
      );
  }
}