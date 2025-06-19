import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/presentation/widgets/app_bar.dart';
import 'package:pr1/presentation/widgets/text.dart';

class InboxAppbar {
  static AppBar buildInboxAppBar(BuildContext context) {
    return MyAppBar.appBar(
      backgroundColor: transparent,
      centerTitle: false,
      foregroundColor: white,
      context,
      title: Column(
        children: [
          MyText.text1('Inbox',
              textColor: white, fontSize: 22, fontWeight: FontWeight.bold),
          MyText.text1('Inbox', textColor: Colors.grey[400], fontSize: 16),
        ],
      ),
      bottom: TabBar(
        tabs: [
          Tab(text: "pending"),
          Tab(text: "in progress"),
          Tab(text: "Completed"),
        ],
      )
    );
  }
}
