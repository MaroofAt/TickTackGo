import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/presentation/widgets/app_bar.dart';
import 'package:pr1/presentation/widgets/text.dart';

class ShowTasksAppBar {
  static AppBar showTasksAppBar(BuildContext context) {
    return MyAppBar.appBar(
      context,
      title: MyText.text1('Task list'),
      backgroundColor: transparent,
    );
  }
}
