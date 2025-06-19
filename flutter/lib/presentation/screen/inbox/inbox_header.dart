import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/presentation/widgets/text.dart';

class InboxHeader extends StatelessWidget {
  const InboxHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context),
      height: height(context) * 0.1,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.text1(
            'Inbox',
            textColor: white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          MyText.text1(
            'Create your own todo list here ',
            textColor: Colors.grey[400],
            fontSize: 16,
          ),
        ],
      ),
    );
  }
}
