import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/presentation/widgets/app_bar.dart';
import 'package:pr1/presentation/widgets/text.dart';

class TaskInfoAppBar {
  static AppBar taskInfoAppBar(BuildContext context, String title) {
    return MyAppBar.appBar(
      context,
      title: MyText.text1(title),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      foregroundColor: white,
    );
  }
}
