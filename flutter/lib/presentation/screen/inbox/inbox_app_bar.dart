import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/presentation/widgets/app_bar.dart';
import 'package:pr1/presentation/widgets/text.dart';

class InboxAppBar {
  static AppBar inboxAppBar(BuildContext context) {
    return MyAppBar.appBar(
      context,
      foregroundColor: white,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor.withAlpha(150),
      title: MyText.text1('your own todo list'),
      bottom: const TabBar(
        labelColor: white,
        dividerColor: Colors.black,
        tabs: [
          Tab(text: 'pending'),
          Tab(text: 'in progress'),
          Tab(text: 'completed'),
        ],
      ),
    );
  }
}
