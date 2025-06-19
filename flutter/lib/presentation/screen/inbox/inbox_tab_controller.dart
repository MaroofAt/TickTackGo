import 'package:flutter/material.dart';
import 'package:pr1/presentation/widgets/app_bar.dart';
import 'package:pr1/presentation/widgets/text.dart';

class InboxTabController extends StatelessWidget {
  const InboxTabController({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: TabBar(
        tabs: [
          Tab(child: MyText.text1('Pending')),
          Tab(child: MyText.text1('In progress')),
          Tab(child: MyText.text1('Completed')),
        ],
      ),
    );
  }
}
