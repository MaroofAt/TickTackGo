import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/presentation/widgets/app_bar.dart';
import 'package:pr1/presentation/widgets/text.dart';

class PointsStatisticsAppBar {
  static AppBar pointsStatisticsDependenciesAppBar(
      BuildContext context, String workspaceName) {
    return MyAppBar.appBar(
      context,
      title: MyText.text1(workspaceName),
      foregroundColor: white,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}
